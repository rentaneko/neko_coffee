// ignore_for_file: public_member_api_docs, sort_constructors_first
class Blog {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imgUrl;
  final DateTime updateAt;
  final String? posterName;

  Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imgUrl,
    required this.updateAt,
    this.posterName,
  });
}
