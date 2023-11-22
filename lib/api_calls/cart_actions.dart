import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clients_products_page/models/cart_item.dart';

class CartActions {
  final String baseUrl =
      'http://192.168.0.70:8080/api/cart'; // Replace with your actual API base URL

  Future<List<CartItem>> fetchCart(String? email, String? password) async {
    final url = baseUrl;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print("response= ${response}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        // Convert the JSON data to a list of CartItem objects
        List<CartItem> cartItems = List<CartItem>.from(
            data.map((itemData) => CartItem.fromJson(itemData)));

        return cartItems;
      } else {
        print('Failed to fetch cart data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch cart data');
      }
    } catch (error) {
      print('Error fetching cart: $error');
      throw Exception('Error: $error');
    }
  }

  Future<List<CartItem>> addToCart(email, password, productId) async {
    final url = '$baseUrl/add';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'email': email, 'password': password, "product_id": productId}),
      );
      print("response= ${response}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        // Convert the JSON data to a list of CartItem objects
        List<CartItem> cartItems = List<CartItem>.from(
            data.map((itemData) => CartItem.fromJson(itemData)));

        return cartItems;
      } else {
        print('Failed to fetch cart data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch cart data');
      }
    } catch (error) {
      print('Error fetching cart: $error');
      throw Exception('Error: $error');
    }
  }

  Future<List<CartItem>> updateQuantity(
      email, password, productId, quantity) async {
    final url = '$baseUrl/update';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'product_id': productId,
          'quantity': quantity
        }),
      );
      print("response= ${response}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        // Convert the JSON data to a list of CartItem objects
        List<CartItem> cartItems = List<CartItem>.from(
            data.map((itemData) => CartItem.fromJson(itemData)));

        return cartItems;
      } else {
        print('Failed to fetch cart data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch cart data');
      }
    } catch (error) {
      print('Error fetching cart: $error');
      throw Exception('Error: $error');
    }
  }
}
