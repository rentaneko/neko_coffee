import 'dart:io';

import 'package:dio/dio.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/blog.model.dart';

abstract interface class BlogApi {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog});

  Future<List<BlogModel>> getAllBlog();
}

class BlogApiImpl implements BlogApi {
  final SupabaseClient client;

  BlogApiImpl(this.client);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await client.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(blogData.first);
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      client.storage.from('blog_images').upload(blog.id, image);

      return client.storage.from('blog_images').getPublicUrl(blog.id);
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }

  @override
  Future<List<BlogModel>> getAllBlog() async {
    try {
      final blogs = (await client.from('blogs').select('*'))
          .map((map) => BlogModel.fromJson(map).copyWith(
                id: map['id'] as String,
                posterId: map['poster_id'] as String,
                title: map['title'] as String,
                content: map['content'] as String,
                imgUrl: map['img_url'] as String,
                updateAt: map['updated_at'] == null
                    ? DateTime.now()
                    : DateTime.parse(map['updated_at']),
                // posterName: map['full_name'] as String,
              ))
          .toList();
      return blogs;
    } on DioException catch (e) {
      throw ServerError.handleException(e);
    }
  }
}
