import 'package:flutter/material.dart';
import 'package:mnb_mobile/app/widgets/inputs/input_decoration.dart';
import 'package:mnb_mobile/theme/colors.dart';

/// One selectable option for [AppDropdownField].
class AppDropdownItem<T> {
  const AppDropdownItem({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// A reusable, themed dropdown field with an external label.
class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.label,
    this.hint,
    this.validator,
    this.isRequired = false,
    this.enabled = true,
    this.prefixIcon,
  });

  final List<AppDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hint;
  final String? Function(T?)? validator;
  final bool isRequired;
  final bool enabled;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          AppFieldLabel(label: label!, isRequired: isRequired),
        DropdownButtonFormField<T>(
          initialValue: value,
          isExpanded: true,
          validator: validator,
          onChanged: enabled ? onChanged : null,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ChakraColors.gray500,
          ),
          style: AppInputTokens.inputTextStyle,
          dropdownColor: ChakraColors.white,
          borderRadius: BorderRadius.circular(AppInputTokens.radius),
          decoration: AppInputTokens.decoration(
            hint: hint,
            enabled: enabled,
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, color: ChakraColors.gray500, size: 20),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item.value,
                  child: Row(
                    children: [
                      if (item.icon != null) ...[
                        Icon(item.icon, size: 18, color: ChakraColors.gray600),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          item.label,
                          overflow: TextOverflow.ellipsis,
                          style: AppInputTokens.inputTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
