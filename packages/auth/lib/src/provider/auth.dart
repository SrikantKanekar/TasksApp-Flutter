import 'package:auth/src/model/user.dart';
import 'package:auth/src/network/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  User? _user;

  bool get isAuth {
    return _user != null;
  }

  User? get getUser {
    return _user;
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      var token = await Network.register(
        email: email,
        username: username,
        password: password,
      );
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      _user = User.fromMap(decodedToken);
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      var token = await Network.login(
        email: email,
        password: password,
      );
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      _user = User.fromMap(decodedToken);
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      _user = User.fromMap(decodedToken);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> deleteAccount() async {
    logout();
  }
}
