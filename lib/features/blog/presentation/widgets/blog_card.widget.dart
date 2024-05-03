import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neko_coffee/core/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          color: Colors.white,
          border: Border.all(color: Colors.pink.shade700, width: 5),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: blog.imgUrl,
                errorWidget: (context, url, error) =>
                    SvgPicture.asset('assets/svg/invalidImage.svg'),
                fit: BoxFit.cover,
                height: 80.w,
              ),
            ),
            SizedBox(height: 12.w),
            Text(
              blog.title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 18.spMin,
              ),
            ),
            SizedBox(height: 12.w),
            Text(
              blog.content,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 16.spMin,
              ),
              maxLines: null,
            ),
          ],
        ));
  }
}
