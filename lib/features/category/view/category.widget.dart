import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/features/category/bloc/index.dart';

class CategoryWidget {
  static Widget subCategoryButton({required CategoryBloc categoryBloc}) {
    return SizedBox(
      width: double.infinity,
      height: 120.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categoryBloc.subCates.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              categoryBloc.idSubCategory = categoryBloc.subCates[index].id!;
              categoryBloc.add(SubCategoryClickedEvent(
                  idSubCategory: categoryBloc.subCates[index].id!));
            },
            child: Container(
              padding: EdgeInsets.all(12.w),
              color:
                  categoryBloc.idSubCategory == categoryBloc.subCates[index].id
                      ? Colors.green.shade100
                      : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    '${categoryBloc.subCates[index].icon}',
                    fit: BoxFit.contain,
                    height: 35.h,
                  ),
                  SizedBox(height: 12.h),
                  Text('${categoryBloc.subCates[index].name}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
