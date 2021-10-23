import 'dart:convert';

import 'package:http/http.dart' as http;

const headers = {
  "Accept": "application/json",
  "content-type": "application/json"
};

class Network {
  static Future<String> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse('http://10.0.2.2:3000/auth/login');
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    var response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) return response.body;
    throw Exception(response.body);
  }

  static Future<String> register({
    required String email,
    required String username,
    required String password,
  }) async {
    var url = Uri.parse('http://10.0.2.2:3000/auth/register');
    var body = jsonEncode({
      'username': username,
      'email': email,
      'password1': password,
      'password2': password,
    });
    var response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) return response.body;
    throw Exception(response.body);
  }
}
