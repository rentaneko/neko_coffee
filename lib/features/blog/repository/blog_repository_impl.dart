import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/blog.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/network/connetion_checker.dart';
import 'package:neko_coffee/domain/datasource/local/blog_local_data.dart';
import 'package:neko_coffee/domain/datasource/remote/blog_api.dart';
import 'package:neko_coffee/domain/models/blog.model.dart';
import 'package:neko_coffee/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogApi blogApi;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl(
    this.blogApi,
    this.blogLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<ServerError, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String posterId}) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(ServerError.network());
      }

      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imgUrl: '',
        updateAt: DateTime.now(),
      );

      final imageUrl =
          await blogApi.uploadBlogImage(image: image, blog: blogModel);
      blogModel = blogModel.copyWith(imgUrl: imageUrl);

      final uploadBlog = await blogApi.uploadBlog(blogModel);
      return right(uploadBlog);
    } on DioException catch (e) {
      return left(ServerError.handleException(e));
    }
  }

  @override
  Future<Either<ServerError, List<Blog>>> getAllBlog() async {
    try {
      if (!await connectionChecker.isConnected) {
        final blogs = blogLocalDataSource.loadBlogs();

        return right(blogs.sortWithDate((instance) => instance.updateAt));
      }
      final blogs = await blogApi.getAllBlog();
      blogLocalDataSource.uploadLocalBlog(blogs: blogs);
      return right(blogs);
    } on DioException catch (e) {
      return left(ServerError.handleException(e));
    }
  }
}
