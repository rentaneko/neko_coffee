import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/common/widgets/empty.widget.dart';
import 'package:neko_coffee/common/widgets/failure.widget.dart';
import 'package:neko_coffee/common/widgets/loading.widget.dart';
import 'package:neko_coffee/features/category/bloc/index.dart';
import 'package:neko_coffee/features/category/view/category.widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.categoryBloc});
  final CategoryBloc categoryBloc;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedCate = 0;

  @override
  void initState() {
    widget.categoryBloc.add(InitialCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      bloc: widget.categoryBloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoadingCategoryState():
            return const LoadingWidget();

          case LoadingSuccessCategoryState:
            state as LoadingSuccessCategoryState;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: state.cate.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() => selectedCate = index);
                          widget.categoryBloc.add(
                            CategoryClickedEvent(
                                idParent: state.cate[index].id!,
                                cates: state.cate),
                          );
                        },
                        child: Container(
                          color: selectedCate == index
                              ? Colors.amber.shade100
                              : Colors.white,
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                '${state.cate[index].icon}',
                                fit: BoxFit.contain,
                                height: 80.h,
                              ),
                              SizedBox(height: 12.h),
                              Text('${state.cate[index].name}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: state.subCates.isEmpty
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      Text('${state.cate[selectedCate].name}'),
                      state.subCates.isNotEmpty
                          ? CategoryWidget.subCategoryButton(
                              categoryBloc: widget.categoryBloc)
                          : const EmptyWidget(),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 150.h,
                          crossAxisSpacing: 8.w,
                          mainAxisSpacing: 12.h,
                        ),
                        itemCount: state.products.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.black26,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 10.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  '${state.products[index].imgUrl}',
                                  height: 60.h,
                                  width: 55.w,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  '${state.products[index].name}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${state.products[index].price} \$',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );

          case CategoryLoadingProductState:
            state as CategoryLoadingProductState;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: state.categories.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() => selectedCate = index);
                          widget.categoryBloc.add(
                            CategoryClickedEvent(
                                idParent: state.categories[index].id!,
                                cates: state.categories),
                          );
                        },
                        child: Container(
                          color: selectedCate == index
                              ? Colors.amber.shade100
                              : Colors.white,
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                '${state.categories[index].icon}',
                                fit: BoxFit.contain,
                                height: 80.h,
                              ),
                              SizedBox(height: 12.h),
                              Text('${state.categories[index].name}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: state.subCategories.isEmpty
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      Text('${state.categories[selectedCate].name}'),
                      state.subCategories.isNotEmpty
                          ? CategoryWidget.subCategoryButton(
                              categoryBloc: widget.categoryBloc)
                          : const EmptyWidget(),
                      SizedBox(
                        height: 500.h,
                        child: const Center(child: LoadingWidget()),
                      ),
                    ],
                  ),
                ),
              ],
            );

          case LoadingSubCategoryState:
            state as LoadingSubCategoryState;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: state.cates.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => setState(() => selectedCate = index),
                        child: Container(
                          color: selectedCate == index
                              ? Colors.amber.shade100
                              : Colors.white,
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                '${state.cates[index].icon}',
                                fit: BoxFit.contain,
                                height: 80.h,
                              ),
                              SizedBox(height: 12.h),
                              Text('${state.cates[index].name}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Expanded(flex: 3, child: LoadingWidget()),
              ],
            );

          case ErrorCategoryState:
            state as ErrorCategoryState;
            return FailureWidget(error: state.errorMsg);
          default:
            return const LoadingWidget();
        }
      },
    );
  }
}
