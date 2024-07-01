import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/common/widgets/custom.button.dart';
import 'package:neko_coffee/core/common/widgets/failure.widget.dart';
import 'package:neko_coffee/core/common/widgets/loading.widget.dart';
import 'package:neko_coffee/core/entities/product.dart';
import 'package:neko_coffee/core/entities/topping.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/core/theme/app_style.dart';

import '../../../../core/common/widgets/chip.widget.dart';
import '../../../../core/entities/enum.entity.dart';
import '../../../../core/utils/utils_common.dart';
import '../../bloc/add_to_cart/add_to_cart_bloc.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen(
      {super.key, required this.product, required this.category});
  final Product product;
  final String category;
  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  void initState() {
    context.read<AddToCartBloc>().add(InitialAddToCartEvent(
        idCate: widget.category, idProduct: widget.product.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.light,
      appBar: AppBar(
        title: Text('Customize Order', style: mediumOswald(size: 16)),
        centerTitle: true,
      ),
      body: BlocBuilder<AddToCartBloc, AddToCartState>(
        builder: (context, state) {
          if (state is AddToCartLoading) {
            return const LoadingWidget();
          }
          if (state is AddToCartFailure) {
            return FailureWidget(error: state.error);
          }
          if (state is AddToCartDisplaySuccess) {
            return _body(toppings: state.toppings);
          }
          return Container();
        },
      ),
      bottomNavigationBar: Container(
        height: 70.w,
        color: AppPallete.light,
        padding: EdgeInsets.symmetric(
          vertical: 12.w,
          horizontal: 16.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: regularOswald(size: 14),
                ),
                Text(
                  '124.98934 \$',
                  style: boldOswald(size: 16),
                ),
              ],
            ),
            appButton(
              onPress: () {
                context
                    .read<AddToCartBloc>()
                    .add(AddItemToCartEvent(idProduct: widget.product.id));
              },
              label: 'Add Order',
            ),
          ],
        ),
      ),
    );
  }

  Widget _body({required List<Topping> toppings}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              frameListTopping(toppings: toppings),
              SizedBox(
                height: MediaQuery.of(context).size.height * .35,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.product.iconUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 180.w,
                left: 16.w,
                child: _detailCard(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget frameListTopping({required List<Topping> toppings}) {
    return Container(
      color: AppPallete.light,
      margin: EdgeInsets.only(top: 290.w),
      child: Column(
        children: [
          _selectionNote(),
          addVerticalSpace(20.w),
          Container(
            decoration: BoxDecoration(
              color: AppPallete.light,
              border: Border.all(color: AppPallete.border, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ...toppings.map((e) => buildSingleCheckBox(e)).toList(),
              ],
            ),
          ),
          addVerticalSpace(20.w),
        ],
      ),
    );
  }

  Widget buildSingleCheckBox(Topping topping) {
    return buildCheckBox(topping: topping);
  }

  Widget buildCheckBox({required Topping topping}) {
    return ListTile(
      tileColor: AppPallete.light,
      title: Text(topping.name, style: regularOswald(size: 14)),
      trailing: Checkbox(
        value: topping.value,
        onChanged: (value) {
          setState(() {
            value = !topping.value;
            topping.value = value!;
          });
        },
      ),
    );
  }

  Widget _detailCard() {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      padding: EdgeInsets.symmetric(vertical: 16.w),
      decoration: BoxDecoration(
        color: AppPallete.light,
        border: Border.all(color: AppPallete.border, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              CategoryEnum.getEnumById(widget.category)!.name,
              style: boldOswald(size: 16, color: AppPallete.brand),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.name,
                  style: mediumOswald(size: 18, color: AppPallete.dark),
                ),
                Text(
                  '${widget.product.price} \$',
                  style: mediumOswald(size: 18, color: AppPallete.dark),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/star.png',
                        color: AppPallete.rating,
                        height: 14.w,
                      ),
                      addHorizontalSpace(4.w),
                      Text('4.9', style: boldOswald(size: 12)),
                      addHorizontalSpace(6.w),
                      Text('(23)', style: regularOswald(size: 14)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Rating and Reviews',
                    style: mediumOswald(size: 14),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectionNote() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 12.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppPallete.light,
        border: Border.all(color: AppPallete.border, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Text('Customize', style: boldOswald(size: 16)),
          addVerticalSpace(16.w),
          rowSelectionNote(label: 'Variant', type: 'variant'),
          rowSelectionNote(label: 'Size', type: 'size'),
          rowSelectionNote(label: 'Sugar', type: 'sugar'),
          rowSelectionNote(label: 'Ice', type: 'ice'),
        ],
      ),
    );
  }

  Widget rowSelectionNote({required String label, required String type}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(label, style: regularOswald(size: 14)),
        ),
        Expanded(
          flex: 4,
          child: ChipSelection(selection: type),
        ),
      ],
    );
  }
}
