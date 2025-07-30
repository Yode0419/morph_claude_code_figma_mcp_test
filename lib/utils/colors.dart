import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF4A90E2);
  static const Color successGreen = Color(0xFF5CB85C);
  static const Color warningYellow = Color(0xFFF0AD4E);
  static const Color infoBlue = Color(0xFF5BC0DE);
  static const Color purpleGradientStart = Color(0xFF8B5CF6);
  static const Color purpleGradientEnd = Color(0xFF3B82F6);
  
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;
  static const Color divider = Color(0xFFE5E5E5);

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'booked':
        return warningYellow;
      case 'pre-inspection':
        return infoBlue;
      case 'under inspection':
        return primaryBlue;
      case 'completed':
        return textSecondary;
      default:
        return textSecondary;
    }
  }
}