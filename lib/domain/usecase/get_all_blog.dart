import 'package:fpdart/fpdart.dart';
import 'package:neko_coffee/core/entities/blog.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';

import '../repositories/blog_repository.dart';

class GetAllBlog implements Usecase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlog(this.blogRepository);
  @override
  Future<Either<ServerError, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlog();
  }
}
