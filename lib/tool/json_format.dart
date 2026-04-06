Map<String, dynamic> cleanJson(Map<String, dynamic> json) {
  Map<String, dynamic> newJson =
      Map<String, dynamic>.from(json.map((key, value) {
    if (value.runtimeType.toString().toLowerCase().contains('map')) {
      return MapEntry(key, cleanJson(value));
    }

    if (value.runtimeType.toString().toLowerCase().contains('list')) {
      return MapEntry(key, value.map((e) => cleanJson(e)).toList());
    }

    return MapEntry(key, value);
  }));

  newJson.removeWhere((key, value) {
    if (value.runtimeType.toString().toLowerCase().contains('list')) {
      return value.isEmpty;
    }

    return value == null;
  });

  return newJson;
}
