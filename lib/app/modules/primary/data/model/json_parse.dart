/// Tolerant JSON parsing helpers.
///
/// The backend occasionally serialises numeric values as strings (e.g. the
/// `budget_min` / `budget_max` fields on [PreferenceModel]). These helpers
/// normalise those edge cases so model parsing never throws on a type
/// mismatch.
library;

double? asDoubleOrNull(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

double asDouble(dynamic value, {double fallback = 0}) {
  return asDoubleOrNull(value) ?? fallback;
}

int? asIntOrNull(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

int asInt(dynamic value, {int fallback = 0}) {
  return asIntOrNull(value) ?? fallback;
}

String? asStringOrNull(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

String asString(dynamic value, {String fallback = ''}) {
  return asStringOrNull(value) ?? fallback;
}

bool asBool(dynamic value, {bool fallback = false}) {
  if (value == null) return fallback;
  if (value is bool) return value;
  if (value is String) return value.toLowerCase() == 'true';
  if (value is num) return value != 0;
  return fallback;
}
