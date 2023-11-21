import 'dart:convert';
import 'package:clients_products_page/models/product.dart';
import 'package:clients_products_page/models/products.dart';
import 'package:http/http.dart' as http;

Future<Products> fetchProducts() async {
  final response =
      await http.get(Uri.parse('http://192.168.0.70:8080/api/products'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);

    // Convert the JSON data to a list of Product objects
    List<Product> products = List<Product>.from(
        data.map((productData) => Product.fromJson(productData)));

    // Create a Products instance with the list of products
    Products productsData = Products(products);

    return productsData;
  } else {
    throw Exception('Failed to load products');
  }
}
