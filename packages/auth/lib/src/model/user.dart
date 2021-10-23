class User {
  String email;
  String username;

  User({
    required this.email,
    required this.username,
  });

  Map<String, Object?> toMap() {
    return {
      'email': email,
      'username': username,
    };
  }

  static User fromMap(Map<String, Object?> map) {
    return User(
      email: map['email'] as String,
      username: map['username'] as String,
    );
  }
}
