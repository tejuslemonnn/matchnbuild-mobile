import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mnb_mobile/app/widgets/inputs/input_decoration.dart';
import 'package:mnb_mobile/theme/colors.dart';

/// A reusable, themed text field.
///
/// Handles single-line and multi-line input, optional password visibility
/// toggle, prefix/suffix icons, and an external label with a required marker.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.isRequired = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.autofillHints,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool isRequired;
  final bool enabled;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? autofillHints;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    Widget? suffix = widget.suffixIcon;
    if (widget.obscureText) {
      suffix = IconButton(
        splashRadius: 20,
        icon: Icon(
          _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: ChakraColors.gray500,
          size: 20,
        ),
        onPressed: () => setState(() => _obscured = !_obscured),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          AppFieldLabel(label: widget.label!, isRequired: widget.isRequired),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: _obscured,
          enabled: widget.enabled,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          inputFormatters: widget.inputFormatters,
          autofillHints: widget.autofillHints,
          style: AppInputTokens.inputTextStyle,
          cursorColor: ChakraColors.black,
          decoration: AppInputTokens.decoration(
            hint: widget.hint,
            enabled: widget.enabled,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(
                    widget.prefixIcon,
                    color: ChakraColors.gray500,
                    size: 20,
                  ),
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
