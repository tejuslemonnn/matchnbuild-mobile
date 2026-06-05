import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/theme/colors.dart';

/// Shared visual tokens for all reusable input fields so they look identical.
class AppInputTokens {
  AppInputTokens._();

  static const double radius = 14;
  static const EdgeInsets contentPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 16);

  static OutlineInputBorder _border(Color color, [double width = 1.2]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  /// A consistent [InputDecoration] used by every field. The visible label is
  /// rendered separately (see [AppFieldLabel]) so the layout stays stable.
  static InputDecoration decoration({
    String? hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool enabled = true,
    bool isDense = false,
  }) {
    return InputDecoration(
      hintText: hint,
      isDense: isDense,
      filled: true,
      fillColor: enabled ? ChakraColors.white : ChakraColors.gray100,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintStyle: GoogleFonts.inter(
        fontSize: 13,
        color: ChakraColors.gray400,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: contentPadding,
      border: _border(ChakraColors.gray200),
      enabledBorder: _border(ChakraColors.gray200),
      disabledBorder: _border(ChakraColors.gray100),
      focusedBorder: _border(ChakraColors.black, 1.6),
      errorBorder: _border(ChakraColors.red500),
      focusedErrorBorder: _border(ChakraColors.red500, 1.6),
      errorStyle: GoogleFonts.inter(
        fontSize: 11,
        color: ChakraColors.red600,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static TextStyle get inputTextStyle => GoogleFonts.inter(
        fontSize: 14,
        color: ChakraColors.gray900,
        fontWeight: FontWeight.w500,
      );
}

/// A field label drawn above an input, with an optional required marker.
class AppFieldLabel extends StatelessWidget {
  const AppFieldLabel({super.key, required this.label, this.isRequired = false});

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 2),
      child: RichText(
        text: TextSpan(
          text: label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: ChakraColors.gray700,
          ),
          children: [
            if (isRequired)
              TextSpan(
                text: ' *',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: ChakraColors.red500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
