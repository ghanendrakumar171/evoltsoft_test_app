// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCenterTitle;
  final double elevation;
  final Color? backgroundColor;

  const CustomAppBar(
      {super.key,
      this.title = '',
      this.elevation = 4,
      this.isCenterTitle = true,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundColor ?? Theme.of(context).colorScheme.background,
      elevation: elevation,
      title: Text(title),
      titleTextStyle: Theme.of(context).textTheme.headlineSmall,
      centerTitle: isCenterTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
