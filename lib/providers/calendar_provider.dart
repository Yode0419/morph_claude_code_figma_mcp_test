import 'package:flutter/material.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime(2025, 7, 4);
  DateTime _currentMonth = DateTime(2025, 7);

  DateTime get selectedDate => _selectedDate;
  DateTime get currentMonth => _currentMonth;

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void nextMonth() {
    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    notifyListeners();
  }

  void previousMonth() {
    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    notifyListeners();
  }

  List<DateTime> getWeekDates(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday % 7));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return isSameDay(date, now);
  }
}