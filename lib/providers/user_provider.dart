import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  UserProvider() {
    _initializeDummyUser();
  }

  void _initializeDummyUser() {
    _currentUser = User(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      avatarUrl: null,
      reportsUsed: 3,
      reportsLimit: 5,
      resetDate: DateTime.now().add(const Duration(days: 5)),
      isPremium: false,
    );
  }

  void incrementReportsUsed() {
    if (_currentUser != null && _currentUser!.reportsUsed < _currentUser!.reportsLimit) {
      _currentUser = User(
        id: _currentUser!.id,
        name: _currentUser!.name,
        email: _currentUser!.email,
        avatarUrl: _currentUser!.avatarUrl,
        reportsUsed: _currentUser!.reportsUsed + 1,
        reportsLimit: _currentUser!.reportsLimit,
        resetDate: _currentUser!.resetDate,
        isPremium: _currentUser!.isPremium,
      );
      notifyListeners();
    }
  }

  void upgradeToPremium() {
    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        name: _currentUser!.name,
        email: _currentUser!.email,
        avatarUrl: _currentUser!.avatarUrl,
        reportsUsed: _currentUser!.reportsUsed,
        reportsLimit: 999,
        resetDate: null,
        isPremium: true,
      );
      notifyListeners();
    }
  }
}