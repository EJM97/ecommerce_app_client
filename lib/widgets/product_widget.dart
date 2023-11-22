import 'package:clients_products_page/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:clients_products_page/models/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:clients_products_page/api_calls/cart_actions.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show a modal bottom sheet with product details
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
                child: SizedBox(
              // height: 900,
              width: 380,
              // Customize the appearance of the modal sheet
              // color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                children: [
                  // Display product details here
                  SizedBox(height: 8.0),
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('Price: \$${product.price.toStringAsFixed(2)}'),

                  Text(product.description),
                  SizedBox(height: 8.0),

                  SizedBox(
                    width: 200,
                    child: Image.network(product.image),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: add_to_cart,
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context)
                          .colorScheme
                          .primary, // Use the primary color from the theme
                    ),
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontWeight: FontWeight.bold, // Make the text bold
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ));
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width /
            2, // Half the width of the screen
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name.length < 18
                  ? product.name
                  : "${product.name.substring(0, 15)}...",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              height: 120,
              // clipBehavior: Clip.antiAlias,
              child: Image.network(
                product.image,
                width: double.infinity,
                height: 120.0,
                fit: BoxFit.cover,
              ),
            ),
            // SizedBox(height: 8.0),
            // Text(
            //   'Price: \$${product.price}',
            //   style: TextStyle(
            //     fontSize: 14.0,
            //     color: Theme.of(context).colorScheme.secondary,
            //   ),
            // ),
            // SizedBox(height: 16.0),
            // InkWell(
            //   onTap: () {
            //     // Navigate to a different page based on the product id
            //     Navigator.pushNamed(context, '/productDetails/${product.id}');
            //   },
            //   child: Container(
            //     padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            //     decoration: BoxDecoration(
            //       color: Theme.of(context).colorScheme.primary,
            //       borderRadius: BorderRadius.circular(4.0),
            //     ),
            //     child: Text(
            //       'View Details',
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> add_to_cart() async {
    final CartActions cartActions = CartActions();
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    List<dynamic> cartItems = [];

    String? userEmail = await secureStorage.read(key: 'email');
    String? userPassword = await secureStorage.read(key: 'password');

    Future<List<CartItem>> updated_cart =
        cartActions.addToCart(userEmail, userPassword, product.id);
  }
}
