import 'package:flutter/material.dart';

/// Creates a Text field with the app design to use on all pages.
class MetinTextField extends StatelessWidget {
  const MetinTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.isObscure = false,
    this.isRoundedDesign = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.controller,
    this.floatingLabelBehavior,
    this.suffixIcon,
    this.prefixIcon,
    this.hintStyle,
    this.inputTextStyle,
    this.focusNode,
    this.borderColor,
    this.onEditingComplete,
  }) : super(key: key);

  /// The hint of what the user should enter
  final String? hintText;

  /// The label of the Text field
  final String? labelText;

  /// Is the Text field for a password
  final bool isObscure;

  /// The max number of the text field line
  final int? maxLines;

  /// The min number of the text field line
  final int minLines;

  /// What will happen when the value entered changes
  final void Function(String)? onChanged;

  /// The text field controller
  final TextEditingController? controller;

  /// The label behaviour
  final FloatingLabelBehavior? floatingLabelBehavior;

  final bool isRoundedDesign;

  final Widget? suffixIcon;

  final Widget? prefixIcon;

  final TextStyle? hintStyle;

  final TextStyle? inputTextStyle;

  final FocusNode? focusNode;

  final Color? borderColor;

  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      style: inputTextStyle,
      onEditingComplete: onEditingComplete,
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: isObscure,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: hintStyle ?? Theme.of(context).textTheme.subtitle2,
        floatingLabelBehavior: floatingLabelBehavior,
        enabledBorder: isRoundedDesign
            ? OutlineInputBorder(
                borderSide:
                    BorderSide(color: borderColor ?? const Color(0xffE8E6EA)),
                borderRadius: BorderRadius.circular(15.0),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
        hintText: hintText,
        labelText: labelText,
        focusedBorder: isRoundedDesign
            ? OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(15.0))
            : UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
      ),
    );
  }
}
