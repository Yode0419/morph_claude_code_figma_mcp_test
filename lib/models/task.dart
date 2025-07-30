enum TaskStatus {
  booked,
  preInspection,
  underInspection,
  completed
}

class Task {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String assignedTo;
  final TaskStatus status;
  final String? phoneNumber;
  final double? latitude;
  final double? longitude;

  Task({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.assignedTo,
    required this.status,
    this.phoneNumber,
    this.latitude,
    this.longitude,
  });

  String get statusText {
    switch (status) {
      case TaskStatus.booked:
        return 'Booked';
      case TaskStatus.preInspection:
        return 'Pre-Inspection';
      case TaskStatus.underInspection:
        return 'Under Inspection';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  String get actionButtonText {
    switch (status) {
      case TaskStatus.booked:
        return 'Setup';
      case TaskStatus.preInspection:
        return 'Start';
      case TaskStatus.underInspection:
        return 'Continue';
      case TaskStatus.completed:
        return 'Report';
    }
  }
}