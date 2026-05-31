import 'package:intl/intl.dart';

final _rupiahFormat = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp. ',
  decimalDigits: 0,
);

/// Formats a numeric value as Indonesian Rupiah, e.g. `Rp. 45.000.000`.
/// Returns [fallback] when [value] is null.
String formatRupiah(num? value, {String fallback = '-'}) {
  if (value == null) return fallback;
  return _rupiahFormat.format(value);
}
