import 'package:intl/intl.dart';

class AppDateUtils {
  static String formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  static String formatTimeRange(DateTime start, DateTime end) {
    return '${formatTime(start)} - ${formatTime(end)}';
  }

  static String formatMonthYear(DateTime dateTime) {
    return DateFormat('MMM - MMM yyyy').format(dateTime);
  }

  static String formatDayMonth(DateTime dateTime) {
    return DateFormat('MMMM d').format(dateTime);
  }

  static String formatWeekday(DateTime dateTime) {
    return DateFormat('E').format(dateTime).substring(0, 1);
  }

  static String formatDay(DateTime dateTime) {
    return DateFormat('d').format(dateTime);
  }
}