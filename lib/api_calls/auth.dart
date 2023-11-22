import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clients_products_page/models/user.dart'; //will be needed if api response sends user details on login

class Auth {
  final String baseUrl = 'http://192.168.0.70:8080/api/auth';

  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> secureStore(String email, String password) async {
    await secureStorage.write(key: 'email', value: email);
    await secureStorage.write(key: 'password', value: password);
  }

  Future<String?> login(String email, String password) async {
    // Future<User?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successful login, parse the response JSON into a User object
      // final userData = jsonDecode(response.body);
      final userData = response.body;
      // return User.fromJson(userData);
      print(userData);
      if (userData == "email psw found") {
        await secureStore(email, password);
        return "email psw found";
      }
      return null;
    } else {
      // Login failed, handle errors here
      // You might want to throw an exception or return null
      return null;
    }
  }

  Future<String?> register(String name, String email, String password) async {
    // Future<User?> register(String email, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successful register, parse the response JSON into a User object
      final userData = response.body;
      // return User.fromJson(userData);
      print(userData);
      await secureStore(email, password);
      return "Registered Successfully";
    } else {
      final userData = jsonDecode(response.body);
      print('Error: ${userData["error"]}');
      // register failed, handle errors here
      // You might want to throw an exception or return null
      return "Registration unsuccessful, probable cause: Email already exists. Error details: ${userData["error"]}";
    }
  }
}
