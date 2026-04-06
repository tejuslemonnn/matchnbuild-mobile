import 'package:intl/intl.dart';

class DateFormater {
  static DateFormat get dMYHi {
    return DateFormat('dd MMMM yyyy hh:mm', 'id');
  }

  // ignore: non_constant_identifier_names
  static DateFormat get YmdHi {
    return DateFormat('yyyy-MM-dd hh:mm');
  }

  static DateFormat get ymd {
    return DateFormat('yyyy-MM-dd');
  }

  static DateFormat get dMYFull {
    return DateFormat('dd MMMM yyyy hh:mm', 'id');
  }

  static DateFormat get dmY {
    return DateFormat('dd/MM/yy');
  }

  static DateFormat get dmYHi {
    return DateFormat('dd/MM/yy hh:mm', 'id');
  }
}

final days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];

String calculateDate(
  DateTime date, {
  bool withTime = true,
  bool isShorten = false,
}) {
  final now = DateTime.now();
  final diff = DateTime(
    date.year,
    date.month,
    date.day,
  ).difference(DateTime(now.year, now.month, now.day));

  final time = DateFormat('hh:mm', 'id').format(date);

  if (diff.inDays == 0) {
    return 'Hari ini, $time';
  }

  if (diff.inDays == -1) {
    return 'Kemarin, $time';
  }

  if (diff.inDays == 1) {
    return 'Besok, $time';
  }

  if (diff.inDays == 2) {
    return 'Lusa, $time';
  }

  if (diff.inDays > -7) {
    return "${days[date.weekday - 1]}, $time";
  }

  String dateString = DateFormat('dd MMMM yyyy', 'id').format(date);

  if (isShorten) {
    dateString = DateFormat('dd/MM/yyyy', 'id').format(date);
  }

  if (withTime) {
    dateString += " • ${DateFormat('hh:mm', 'id').format(date)}";
  }

  return dateString;
}
