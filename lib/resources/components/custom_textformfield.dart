import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String label;
  final IconData icon;
  final bool canEdit;
  final bool obscureText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController textEditingController;
  final bool textFieldEnabled;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.validator,
    this.keyboardType,
    this.label = '',
    this.canEdit = true,
    required this.textEditingController,
    this.focusNode,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.textFieldEnabled = true,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: keyboardType,
      focusNode: focusNode,
      obscureText: obscureText,
      enabled: textFieldEnabled,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade200,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
  }
}
