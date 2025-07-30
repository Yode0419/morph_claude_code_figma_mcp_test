import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  
  List<Task> get tasks => _tasks;

  TaskProvider() {
    _initializeDummyData();
  }

  void _initializeDummyData() {
    _tasks = [
      Task(
        id: '1',
        startTime: DateTime(2025, 7, 1, 9, 0),
        endTime: DateTime(2025, 7, 1, 11, 0),
        address: '101 California Street',
        city: 'San Francisco',
        state: 'CA',
        zipCode: '94111',
        assignedTo: 'Robert Jenkins',
        status: TaskStatus.completed,
        phoneNumber: '+1234567890',
      ),
      Task(
        id: '2',
        startTime: DateTime(2025, 7, 1, 9, 0),
        endTime: DateTime(2025, 7, 1, 11, 0),
        address: '101 California Street',
        city: 'San Francisco',
        state: 'CA',
        zipCode: '94111',
        assignedTo: 'Robert Jenkins',
        status: TaskStatus.completed,
        phoneNumber: '+1234567890',
      ),
      Task(
        id: '3',
        startTime: DateTime(2025, 7, 4, 13, 0),
        endTime: DateTime(2025, 7, 4, 15, 0),
        address: '789 Mission Street',
        city: 'San Francisco',
        state: 'CA',
        zipCode: '94103',
        assignedTo: 'Jessica Miller',
        status: TaskStatus.underInspection,
        phoneNumber: '+1234567891',
      ),
      Task(
        id: '4',
        startTime: DateTime(2025, 7, 4, 16, 0),
        endTime: DateTime(2025, 7, 4, 18, 0),
        address: '500 Castro Street',
        city: 'San Francisco',
        state: 'CA',
        zipCode: '94114',
        assignedTo: 'Emily Thompson',
        status: TaskStatus.preInspection,
        phoneNumber: '+1234567892',
      ),
      Task(
        id: '5',
        startTime: DateTime(2025, 7, 4, 19, 30),
        endTime: DateTime(2025, 7, 4, 21, 30),
        address: '1234 Lombard Street',
        city: 'San Francisco',
        state: 'CA',
        zipCode: '94133',
        assignedTo: 'Eric Johnson',
        status: TaskStatus.booked,
        phoneNumber: '+1234567893',
      ),
    ];
  }

  List<Task> getTasksForDate(DateTime date) {
    return _tasks.where((task) {
      return task.startTime.year == date.year &&
          task.startTime.month == date.month &&
          task.startTime.day == date.day;
    }).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  void updateTaskStatus(String taskId, TaskStatus newStatus) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = Task(
        id: _tasks[index].id,
        startTime: _tasks[index].startTime,
        endTime: _tasks[index].endTime,
        address: _tasks[index].address,
        city: _tasks[index].city,
        state: _tasks[index].state,
        zipCode: _tasks[index].zipCode,
        assignedTo: _tasks[index].assignedTo,
        status: newStatus,
        phoneNumber: _tasks[index].phoneNumber,
        latitude: _tasks[index].latitude,
        longitude: _tasks[index].longitude,
      );
      notifyListeners();
    }
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  bool hasTasksOnDate(DateTime date) {
    return _tasks.any((task) {
      return task.startTime.year == date.year &&
          task.startTime.month == date.month &&
          task.startTime.day == date.day;
    });
  }
}