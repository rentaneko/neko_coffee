import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/common/widgets/failure.widget.dart';
import 'package:neko_coffee/core/common/widgets/loading.widget.dart';
import 'package:neko_coffee/core/routes/route_name.dart';
import 'package:neko_coffee/features/auth/bloc/auth_bloc.dart';
import 'package:neko_coffee/features/blog/presentation/page/add_new_blog.screen.dart';
import 'package:neko_coffee/features/blog/presentation/widgets/blog_card.widget.dart';
import '../../../../core/entities/blog.dart';
import '../../bloc/blog_bloc.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});
  static route() => MaterialPageRoute(builder: (_) => const BlogScreen());

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    context.read<BlogBloc>().add(FetchAllBlog());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthUserLogout());
            Navigator.of(context).pushNamedAndRemoveUntil(
                RoutesName.loginPath, (route) => false);
          },
          icon: const Icon(Icons.logout),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).push(AddNewBlogScreen.route()),
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        bloc: context.read<BlogBloc>(),
        builder: (context, state) {
          if (state is BlogLoading) {
            return const LoadingWidget();
          }

          if (state is BlogFailure) {
            return FailureWidget(error: state.error);
          }

          if (state is BlogDisplaySuccess) {
            return _body(state.blogs);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _body(List<Blog> list) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final blog = list[index];
        return BlogCard(blog: blog);
      },
      separatorBuilder: (context, index) => SizedBox(height: 10.w),
      itemCount: list.length,
      shrinkWrap: true,
    );
  }
}
