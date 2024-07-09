import 'package:flutter/material.dart';
import 'package:neko_coffee/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  const BasicAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: title ?? const SizedBox(),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: context.isDarkMode ? Colors.white : Colors.black,
          size: 15,
        ),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
