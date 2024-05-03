import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';
import 'package:neko_coffee/domain/usecase/upload_blog.dart';
import '../../../../core/entities/blog.dart';
import '../../../../domain/usecase/get_all_blog.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlog _getAllBlog;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlog getAllBlog})
      : _uploadBlog = uploadBlog,
        _getAllBlog = getAllBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(blogUpload);
    on<FetchAllBlog>(fetchAllBlog);
  }

  FutureOr<void> blogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
      ),
    );

    res.fold(
      (l) => emit(BlogFailure(l)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  FutureOr<void> fetchAllBlog(
      FetchAllBlog event, Emitter<BlogState> emit) async {
    final res = await _getAllBlog(NoParams());
    res.fold(
      (l) => emit(BlogFailure(l)),
      (r) => emit(BlogDisplaySuccess(blogs: r)),
    );
  }
}
