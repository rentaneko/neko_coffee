import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import '../../../core/entities/blog.dart';

abstract interface class BlogRepository {
  Future<Either<ServerError, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
  });

  Future<Either<ServerError, List<Blog>>> getAllBlog();
}
