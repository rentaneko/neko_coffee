import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/common/widgets/empty.widget.dart';
import 'package:neko_coffee/common/widgets/failure.widget.dart';
import 'package:neko_coffee/common/widgets/loading.widget.dart';
import 'package:neko_coffee/features/category/index.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final categoryBloc = CategoryBloc(InitialCategoryState());
  int selectedCate = 0;

  @override
  void initState() {
    categoryBloc.add(InitialCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      bloc: categoryBloc,
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
                          categoryBloc.add(
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
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: state.subCates.isEmpty
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      Text('${state.cate[selectedCate].name}'),
                      state.subCates.isNotEmpty
                          ? GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 150,
                              ),
                              shrinkWrap: true,
                              itemCount: state.subCates.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: EdgeInsets.all(12.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        '${state.subCates[index].icon}',
                                        fit: BoxFit.contain,
                                        height: 85.h,
                                      ),
                                      SizedBox(height: 12.h),
                                      Text('${state.subCates[index].name}'),
                                    ],
                                  ),
                                );
                              },
                            )
                          : const EmptyWidget(),
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
                const Expanded(flex: 2, child: LoadingWidget()),
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
