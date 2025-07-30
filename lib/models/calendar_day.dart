import 'task.dart';

class CalendarDay {
  final DateTime date;
  final List<Task> tasks;
  final bool isSelected;
  final bool isToday;

  CalendarDay({
    required this.date,
    required this.tasks,
    required this.isSelected,
    required this.isToday,
  });

  CalendarDay copyWith({
    DateTime? date,
    List<Task>? tasks,
    bool? isSelected,
    bool? isToday,
  }) {
    return CalendarDay(
      date: date ?? this.date,
      tasks: tasks ?? this.tasks,
      isSelected: isSelected ?? this.isSelected,
      isToday: isToday ?? this.isToday,
    );
  }

  bool get hasTasks => tasks.isNotEmpty;
}