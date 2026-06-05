import 'package:flutter/material.dart';
import 'package:mnb_mobile/app/widgets/inputs/input_decoration.dart';
import 'package:mnb_mobile/theme/colors.dart';

/// A reusable rounded search field with a leading search icon and an optional
/// trailing action (e.g. a filter button). Shows a clear button while typing.
class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.hint = 'Cari...',
    this.onChanged,
    this.onSubmitted,
    this.onFilterTap,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onFilterTap;
  final bool autofocus;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffix;
    if (_hasText) {
      suffix = IconButton(
        splashRadius: 18,
        icon: const Icon(Icons.close, size: 18, color: ChakraColors.gray500),
        onPressed: _clear,
      );
    } else if (widget.onFilterTap != null) {
      suffix = IconButton(
        splashRadius: 18,
        icon: const Icon(Icons.tune, size: 20, color: ChakraColors.gray600),
        onPressed: widget.onFilterTap,
      );
    }

    return TextField(
      controller: _controller,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      textInputAction: TextInputAction.search,
      style: AppInputTokens.inputTextStyle,
      cursorColor: ChakraColors.black,
      decoration: AppInputTokens.decoration(
        hint: widget.hint,
        isDense: true,
        prefixIcon: const Icon(
          Icons.search,
          color: ChakraColors.gray500,
          size: 22,
        ),
        suffixIcon: suffix,
      ),
    );
  }
}
