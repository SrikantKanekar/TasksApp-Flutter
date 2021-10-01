import 'dart:convert';

class User {
  String email;
  String username;
  String password;
  List<String> favourites;

  User({
    required this.email,
    required this.username,
    required this.password,
    required this.favourites,
  });

  Map<String, Object?> toMap() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'favourites': json.encode(favourites),
    };
  }

  static User fromMap(Map<String, Object?> map) {
    List<String> fav = [];
    var list = json.decode(map['favourites'] as String);
    list.forEach((element) {
      fav.add(element.toString());
    });
    return User(
      email: map['email'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      favourites: fav,
    );
  }
}
