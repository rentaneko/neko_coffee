import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';
import 'package:neko_coffee/domain/repositories/blog_repository.dart';
import '../../core/entities/blog.dart';

class UploadBlog implements Usecase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);

  @override
  Future<Either<ServerError, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
  });
}
