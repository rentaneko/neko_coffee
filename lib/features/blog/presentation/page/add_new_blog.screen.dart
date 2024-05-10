import 'dart:io';

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neko_coffee/core/common/cubit/app_user_cubit.dart';
import 'package:neko_coffee/core/common/widgets/dialog.widget.dart';
import 'package:neko_coffee/core/common/widgets/failure.widget.dart';
import 'package:neko_coffee/core/common/widgets/loading.widget.dart';
import 'package:neko_coffee/core/utils/pick_img.function.dart';
import 'package:neko_coffee/features/blog/bloc/blog_bloc.dart';
import 'package:neko_coffee/features/blog/presentation/page/blog.screen.dart';
import 'package:neko_coffee/features/blog/presentation/widgets/blog_field.widget.dart';
import 'package:neko_coffee/features/blog/presentation/widgets/pick_img.widget.dart';

class AddNewBlogScreen extends StatefulWidget {
  const AddNewBlogScreen({super.key});
  static route() => MaterialPageRoute(builder: (_) => const AddNewBlogScreen());

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final scrollCtrl = ScrollController();
  final formKey = GlobalKey<FormState>();

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();

  List<String> fruits = [
    'apple',
    'banana',
    'grapes',
    'lemon',
    'melon',
    'orange',
    'pineapple',
    'strawberry',
    'watermelon',
  ];
  List<CoolDropdownItem<String>> fruitDropdownItems = [];

  final fruitDropdownController = DropdownController();
  File? img;

  @override
  void initState() {
    for (var i = 0; i < fruits.length; i++) {
      fruitDropdownItems.add(CoolDropdownItem<String>(
          label: 'Delicious ${fruits[i]}', value: fruits[i]));
    }
    super.initState();
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    contentCtrl.dispose();
    super.dispose();
  }

  void selectImage(ImageSource source) async {
    final pickedImage = await pickImage(source);

    setState(() => img = pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new blog'),
        actions: [
          IconButton(
            onPressed: () => _uploadBlog(),
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showErrorDialog(
              context,
              title: 'Something when wrong',
              descripsion: FailureWidget(error: state.error),
            );
          } else if (state is BlogUploadSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              BlogScreen.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const LoadingWidget();
          }
          return SingleChildScrollView(
            reverse: false,
            controller: scrollCtrl,
            child: Form(key: formKey, child: _body()),
          );
        },
      ),
    );
  }

  void _uploadBlog() {
    if (formKey.currentState!.validate() && img != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.uid;
      context.read<BlogBloc>().add(
            BlogUpload(
              posterId: posterId,
              title: titleCtrl.text.trim(),
              content: contentCtrl.text.trim(),
              image: img!,
            ),
          );
    }
  }

  Widget _body() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          img != null
              ? InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera_alt_outlined),
                            title: const Text('Camera'),
                            onTap: () => selectImage(ImageSource.camera),
                          ),
                          ListTile(
                            leading: const Icon(Icons.image_outlined),
                            title: const Text('Gallery'),
                            onTap: () => selectImage(ImageSource.gallery),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    height: 120.h,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(img!, fit: BoxFit.cover),
                    ),
                  ),
                )
              : pickImg(onPress: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.camera_alt_outlined),
                          title: const Text('Camera'),
                          onTap: () => selectImage(ImageSource.camera),
                        ),
                        ListTile(
                          leading: const Icon(Icons.image_outlined),
                          title: const Text('Gallery'),
                          onTap: () => selectImage(ImageSource.gallery),
                        ),
                      ],
                    ),
                  );
                }),
          SizedBox(height: 20.w),
          CoolDropdown<String>(
            controller: fruitDropdownController,
            dropdownList: fruitDropdownItems,
            defaultItem: null,
            onChange: (value) async {
              if (fruitDropdownController.isError) {
                await fruitDropdownController.resetError();
              }
              fruitDropdownController.close();
            },
            onOpen: (value) {},
            resultOptions: const ResultOptions(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: 200,
              icon: SizedBox(
                width: 10,
                height: 10,
                child: CustomPaint(
                  painter: DropdownArrowPainter(),
                ),
              ),
              render: ResultRender.all,
              placeholder: 'Select Fruit',
              isMarquee: true,
            ),
            dropdownOptions: const DropdownOptions(
              top: -20,
              height: 400,
              gap: DropdownGap.all(5),
              borderSide: BorderSide(width: 1, color: Colors.black),
              padding: EdgeInsets.symmetric(horizontal: 10),
              align: DropdownAlign.left,
              animationType: DropdownAnimationType.size,
            ),
            dropdownTriangleOptions: const DropdownTriangleOptions(
              width: 20,
              align: DropdownTriangleAlign.left,
              borderRadius: 3,
              left: 20,
            ),
            dropdownItemOptions: const DropdownItemOptions(
              isMarquee: true,
              mainAxisAlignment: MainAxisAlignment.start,
              render: DropdownItemRender.all,
              // height: 50,
            ),
          ),
          SizedBox(height: 20.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: inputField(
              title: 'Title',
              controller: titleCtrl,
            ),
          ),
          SizedBox(height: 20.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: inputField(
              title: 'Content',
              controller: contentCtrl,
              isContent: true,
            ),
          ),
        ],
      );
}
