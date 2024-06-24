import 'package:flutter/material.dart';
import 'package:neko_coffee/core/theme/app_pallete.dart';
import 'package:neko_coffee/core/theme/app_style.dart';

class CustomCheckboxTile extends StatefulWidget {
  final String label;
  final double price;
  final String id;
  const CustomCheckboxTile(
      {super.key, required this.label, required this.price, required this.id});
  @override
  State<CustomCheckboxTile> createState() => _CustomCheckboxTileState();
}

class _CustomCheckboxTileState extends State<CustomCheckboxTile> {
  bool tick = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            widget.label,
            style: regularOswald(size: 14, color: AppPallete.dark),
          ),
        ),
        Text(
          '+ ${widget.price} \$',
          style: mediumOswald(size: 14, color: AppPallete.dark),
        ),
        Checkbox(
          value: tick,
          onChanged: (value) => setState(() {
            tick = !tick;
          }),
          activeColor: AppPallete.brand,
        ),
      ],
    );
  }
}
