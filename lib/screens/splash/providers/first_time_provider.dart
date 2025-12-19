
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeProvider with ChangeNotifier {
  bool _isFirstTime = true;

  bool get isFirstTime => _isFirstTime;

  Future<void> checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    _isFirstTime = prefs.getBool('isFirstTime') ?? true;
    notifyListeners();
  }

  Future<void> setFirstTimeComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    _isFirstTime = false;
    notifyListeners();
  }
}