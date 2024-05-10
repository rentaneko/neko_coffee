part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {
  const BlogEvent();
}

final class BlogUpload extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;

  const BlogUpload({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
  });
}

final class FetchAllBlog extends BlogEvent {}
