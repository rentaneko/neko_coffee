import 'package:dio/dio.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/domain/models/user.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteApi {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String phone,
    required String fullname,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();

  Future<UserModel?> userLogout();
}

class AuthRemoteApiImpl implements AuthRemoteApi {
  final SupabaseClient supabaseClient;

  AuthRemoteApiImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> userLogout() async {
    await supabaseClient.auth.signOut(scope: SignOutScope.global);
    return null;
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', supabaseClient.auth.currentUser!.id)
            .single();
        return UserModel.fromJson(userData);
      }
      return null;
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      return UserModel.fromJson(response.user!.toJson());
    } on ServerError catch (e) {
      throw ServerError.custom(
        msg: e.message,
        errorMsg: e.error,
        statusCode: e.status,
        time: e.timestamp,
      );
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String phone,
    required String fullname,
  }) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {
        'full_name': fullname,
        'phone': phone,
      });

      if (response.user == null) {
        throw ServerError.other();
      }

      return UserModel.fromJson(response.user!.toJson());
    } on ServerError catch (e) {
      throw ServerError.custom(
        msg: e.message,
        errorMsg: e.error,
        statusCode: e.status,
        time: e.timestamp,
      );
    }
  }
}
