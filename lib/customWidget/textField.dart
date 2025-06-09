// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:evolesoft_app/utils/appSizes.dart';
import 'package:evolesoft_app/utils/appStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CustomTextFieldType {
  text,
  email,
  confirmEmail,
  number,
  password,
  mobileNumber,
  confirmPassword,
  multiline,
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final TextEditingController? confirmEmail;
  final TextEditingController? confirmPassword;
  final IconData? icon;
  final IconData? suffixIcon;
  final CustomTextFieldType type;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool isValidation;
  final TextAlign textAlign;
  final int? maxLines;
  final int? maxLength;
  final double radiusSize;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.suffixIcon,
    this.type = CustomTextFieldType.text,
    this.obscureText = false,
    this.isValidation = false,
    this.enabled = true,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.radiusSize = AppSizes.sizeTen,
    this.maxLength,
    this.labelText,
    this.confirmPassword,
    this.confirmEmail,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: EdgeInsets.all(AppSizes.sizeTen.w),
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        labelText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
        suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withOpacity(.87),
          ),
          borderRadius: BorderRadius.circular(widget.radiusSize),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.outline.withOpacity(.87),
          ),
          borderRadius: BorderRadius.circular(widget.radiusSize),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.outline.withOpacity(.26),
          ),
          borderRadius: BorderRadius.circular(widget.radiusSize),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(widget.radiusSize),
        ),
      ),
      obscureText: widget.obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      expands: false,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      validator: (value) {
        if (widget.type == CustomTextFieldType.email) {
          if (value == null || value.isEmpty) {
            return AppStrings.pleaseEnterAnEmail;
          }
          if (!value.contains('@')) {
            return AppStrings.pleaseEnteraValidEmail;
          }
        }
        if (widget.type == CustomTextFieldType.confirmEmail) {
          if (value == null || value.isEmpty) {
            return AppStrings.pleaseEnterAnEmail;
          }
          if (!value.contains('@')) {
            return AppStrings.pleaseEnteraValidEmail;
          }
          if (value != widget.confirmEmail!.text) {
            print(value);
            print(widget.confirmEmail!.text);

            return AppStrings.pleaseEnterSameMailId;
          }
        }

        if (widget.type == CustomTextFieldType.mobileNumber) {
          if (value == null || value.isEmpty) {
            return AppStrings.pleaseEnterMobileNumber;
          }
          final n = num.tryParse(value);
          if (n == null) {
            return '"$value" ${AppStrings.isNotAValidNumber}';
          }
        }
        if (widget.maxLength != null &&
            value != null &&
            value.length > widget.maxLength!) {
          return '${AppStrings.exceedsMaximumLengthOf} ${widget.maxLength}';
        }
        if (widget.type == CustomTextFieldType.password) {
          if (value == null || value.isEmpty) {
            return AppStrings.pleaseEnterSamePassword;
          }
        }
        if (widget.type == CustomTextFieldType.confirmPassword) {
          if (value == null || value.isEmpty) {
            return AppStrings.pleaseEnterPassword;
          }
          if (value != widget.confirmPassword!.text) {
            print(value);
            print(widget.confirmPassword!.text);
            return AppStrings.pleaseEnterSamePassword;
          }
        }
        if (widget.type == CustomTextFieldType.text && widget.isValidation) {
          if (value == null || value.isEmpty) {
            return '${AppStrings.pleaseEnter} ${widget.hintText}';
          }
        }
        if (widget.type == CustomTextFieldType.number && widget.isValidation) {
          final n = num.tryParse(value!);
          if (n == null) {
            return '"$value" ${AppStrings.isNotAValidNumber}';
          }
          if (value == null || value.isEmpty) {
            return '${AppStrings.pleaseEnter} ${widget.hintText}';
          }
        }
        return null;
      },
    );
  }
}
