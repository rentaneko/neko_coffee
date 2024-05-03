part of 'blog_bloc.dart';

@immutable
sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogDisplaySuccess extends BlogState {
  final List<Blog> blogs;

  const BlogDisplaySuccess({required this.blogs});
}

final class BlogUploadSuccess extends BlogState {}

final class BlogFailure extends BlogState {
  final ServerError error;

  const BlogFailure(this.error);
}
