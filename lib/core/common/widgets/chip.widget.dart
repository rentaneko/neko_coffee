import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/core/entities/enum.entity.dart';
import 'package:neko_coffee/core/theme/app_style.dart';

import '../../theme/app_pallete.dart';

class ChipSelection extends StatefulWidget {
  const ChipSelection({super.key, required this.selection});

  final String selection;
  @override
  State<ChipSelection> createState() => _ChipSelectionState();
}

class _ChipSelectionState extends State<ChipSelection> {
  @override
  void initState() {
    super.initState();
  }

  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: handleChipWidget(),
    );
  }

  List<Widget> handleChipWidget() {
    switch (widget.selection) {
      case "sugar":
        List<SugarType> sugar = [
          SugarType.less,
          SugarType.normal,
          SugarType.more
        ];
        return List.generate(
          sugar.length,
          (int index) {
            return chip(label: sugar[index].name, index: index);
          },
        ).toList();
      case "size":
        List<SizeCup> size = [SizeCup.regular, SizeCup.medium, SizeCup.large];
        return List.generate(
          size.length,
          (int index) {
            return chip(label: size[index].name, index: index);
          },
        ).toList();
      case "ice":
        List<IceType> ice = [IceType.less, IceType.normal, IceType.more];
        return List.generate(
          ice.length,
          (int index) {
            return chip(label: ice[index].name, index: index);
          },
        ).toList();
      case "variant":
        List<VariantType> variant = [VariantType.ice, VariantType.hot];
        return List.generate(
          variant.length,
          (index) => chip(label: variant[index].name, index: index),
        );

      default:
        return List.generate(
          1,
          (int index) => const SizedBox(),
        ).toList();
    }
  }

  Widget chip({required String label, required int index}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: ChoiceChip(
        padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
        label: Text(
          '${label.characters.first.toUpperCase()}${label.substring(1)}',
          style: mediumOswald(
            size: 12,
            color: value == index ? AppPallete.light : AppPallete.brand,
          ),
        ),
        selectedColor: AppPallete.brand,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(color: AppPallete.brand),
        ),
        backgroundColor: AppPallete.light,
        selected: value == index,
        showCheckmark: false,
        onSelected: (bool selected) {
          setState(() {
            value = selected ? index : index;
          });
        },
      ),
    );
  }
}
