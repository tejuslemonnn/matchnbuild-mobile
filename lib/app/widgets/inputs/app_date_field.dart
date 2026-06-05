import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mnb_mobile/app/widgets/inputs/input_decoration.dart';
import 'package:mnb_mobile/theme/colors.dart';

/// A reusable date field that opens a Material date picker on tap and renders
/// the selected date in a read-only, themed field.
class AppDateField extends StatelessWidget {
  const AppDateField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.hint = 'Pilih tanggal',
    this.isRequired = false,
    this.enabled = true,
    this.firstDate,
    this.lastDate,
    this.validator,
    this.dateFormat,
  });

  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final String? label;
  final String hint;
  final bool isRequired;
  final bool enabled;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(DateTime?)? validator;
  final DateFormat? dateFormat;

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: firstDate ?? DateTime(now.year - 5),
      lastDate: lastDate ?? DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ChakraColors.black,
              onPrimary: ChakraColors.white,
              onSurface: ChakraColors.gray900,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final format = dateFormat ?? DateFormat('dd MMM yyyy', 'id_ID');
    final text = value == null ? '' : format.format(value!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          AppFieldLabel(label: label!, isRequired: isRequired),
        // A read-only field keeps validator/error styling consistent with the
        // other inputs while delegating selection to the date picker.
        TextFormField(
          readOnly: true,
          enabled: enabled,
          onTap: enabled ? () => _pick(context) : null,
          controller: TextEditingController(text: text),
          validator: validator == null ? null : (_) => validator!(value),
          style: AppInputTokens.inputTextStyle,
          decoration: AppInputTokens.decoration(
            hint: hint,
            enabled: enabled,
            prefixIcon: const Icon(
              Icons.calendar_today_outlined,
              color: ChakraColors.gray500,
              size: 18,
            ),
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: ChakraColors.gray500,
            ),
          ),
        ),
      ],
    );
  }
}
