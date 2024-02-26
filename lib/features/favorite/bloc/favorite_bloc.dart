import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/favorite/bloc/index.dart';
import 'package:neko_coffee/models/favourite.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final client = Supabase.instance.client;
  List<FavouriteModel> favouriteList = [];
  FavouriteBloc(FavouriteState initialState) : super(FavouriteInitialState()) {
    on<FavouriteInitialEvent>(favouriteInitialEvent);

    on<RemoveItemClickedEvent>(removeItemClickedEvent);

    on<FavouriteButtonInHomeClickedEvent>(favouriteButtonInHomeClickedEvent);
  }

  FutureOr<void> favouriteInitialEvent(
      FavouriteInitialEvent event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoadingState());
    try {
      await client
          .from('Favourite')
          .select('*, Product(name, img_url, description)')
          .order('Product(name)')
          .then((value) => favouriteList =
              value.map((e) => FavouriteModel.fromJson(e)).toList());

      emit(FavouriteLoadedState(favourites: favouriteList));
    } catch (e) {
      emit(FavouriteErrorState(errorMsg: e.toString()));
    }
  }

  FutureOr<void> removeItemClickedEvent(
      RemoveItemClickedEvent event, Emitter<FavouriteState> emit) async {
    try {
      await client
          .from('Favourite')
          .delete()
          .eq('id_product', event.idProduct)
          .eq('id_user', client.auth.currentUser!.id);
      await client
          .from('Favourite')
          .select('*, Product(name, img_url, description)')
          .order('Product(name)')
          .then((value) => favouriteList =
              value.map((e) => FavouriteModel.fromJson(e)).toList());
      emit(FavouriteLoadedState(favourites: favouriteList));
    } catch (e) {
      emit(FavouriteErrorState(errorMsg: e.toString()));
    }
  }

  bool isFavourite(String id) {
    for (var item in favouriteList) {
      if (item.idProduct == id) {
        return true;
      }
    }
    return false;
  }

  FutureOr<void> favouriteButtonInHomeClickedEvent(
    FavouriteButtonInHomeClickedEvent event,
    Emitter<FavouriteState> emit,
  ) async {
    emit(FavouriteButtonInHomeClickedState());
    try {
      if (isFavourite(event.idProduct)) {
        await client
            .from('Favourite')
            .delete()
            .eq('id_product', event.idProduct)
            .eq('id_user', client.auth.currentUser!.id);
      } else {
        await client.from('Favourite').insert({
          'id_product': event.idProduct,
          'id_user': client.auth.currentUser!.id,
        });
      }

      await client
          .from('Favourite')
          .select('*, Product(name, img_url, description)')
          .order('Product(name)')
          .then((value) => favouriteList =
              value.map((e) => FavouriteModel.fromJson(e)).toList());
      emit(FavouriteLoadedState(favourites: favouriteList));
    } catch (e) {
      emit(FavouriteErrorState(errorMsg: e.toString()));
    }
  }
}
