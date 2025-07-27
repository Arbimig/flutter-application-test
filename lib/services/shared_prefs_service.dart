import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class SharedPrefsService {
  static const _userKey = 'user';

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(user.toJson());
    await prefs.setString(_userKey, json);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_userKey);
    if (json == null) return null;
    return User.fromJson(jsonDecode(json));
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_userKey);
  }

  Future<void> saveBalance(String uPhone, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('balance_$uPhone', value);
  }

  Future<int> getBalance(String uPhone) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('balance_$uPhone') ?? 0;
  }
}