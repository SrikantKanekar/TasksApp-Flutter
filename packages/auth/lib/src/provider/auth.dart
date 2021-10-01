import 'package:auth/src/database/user_database.dart';
import 'package:auth/src/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  User? _user;

  bool get isAuth {
    return _user != null;
  }

  User? get getUser {
    return _user;
  }

  Future<void> register(User newUser) async {
    try{
      var user = await UserDatabase.getUser(newUser.email);
      if (user == null){
        _user = newUser;
        notifyListeners();
        await UserDatabase.insert(newUser);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', newUser.email);
      } else {
        throw Exception('User with given email already exists');
      }
    } catch(e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try{
      var user = await UserDatabase.getUser(email);
      if (user != null && user.password == password){
        _user = user;
        notifyListeners();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
      } else {
        throw Exception('Invalid email or password');
      }
    } catch(e) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    if (email != null) {
      var user = await UserDatabase.getUser(email);
      _user = user;
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
    await UserDatabase.deleteUser(_user!.email);
    logout();
  }

  Future<void> addFavourites(String name) async {
    var success = await UserDatabase.addFavourite(_user!.email, name);
    if (success){
      _user!.favourites.add(name);
      notifyListeners();
    }
  }

  Future<void> removeFavourites(String name) async {
    var success = await UserDatabase.removeFavourite(_user!.email, name);
    if (success){
      _user!.favourites.remove(name);
      notifyListeners();
    }
  }

  bool isFav(String name){
    return _user!.favourites.contains(name);
  }
}
