import 'package:intl/intl.dart';

DateTime? strToDate(String date, DateFormat format) {
  try {
    DateTime result = DateTime.parse(date);
  } catch (e) {
    return null;
  }
}
