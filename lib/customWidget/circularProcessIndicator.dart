// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomCircularProcessIndicator extends StatelessWidget {
  final bool? isLoading;
  const CustomCircularProcessIndicator({
    super.key,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading!,
      child: const Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
