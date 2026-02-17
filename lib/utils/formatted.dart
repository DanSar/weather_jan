import 'package:intl/intl.dart';

class Util {
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEEE, MMM d, y').format(dateTime);
  }

  static String getFormDate(DateTime dateTime) {
    return DateFormat('EEE, MMM d, y').format(dateTime);
  }

  static String getHourMinute(DateTime dateTime) {
    return DateFormat('Hm').format(dateTime);
  }

  static String getMonthDate(DateTime dateTime) {
    return DateFormat('MMM d').format(dateTime);
  }
}
