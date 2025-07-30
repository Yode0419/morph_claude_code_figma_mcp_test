class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final int reportsUsed;
  final int reportsLimit;
  final DateTime? resetDate;
  final bool isPremium;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.reportsUsed,
    required this.reportsLimit,
    this.resetDate,
    required this.isPremium,
  });

  int get reportsRemaining => reportsLimit - reportsUsed;
  
  int get daysUntilReset {
    if (resetDate == null) return 0;
    return resetDate!.difference(DateTime.now()).inDays;
  }
}