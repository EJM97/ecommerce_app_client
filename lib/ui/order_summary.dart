import 'package:clients_products_page/widgets/cart_item_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:clients_products_page/widgets/cart_item_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:clients_products_page/api_calls/cart_actions.dart';
import 'package:data_tables/data_tables.dart';

class OrderSummaryPage extends StatefulWidget {
  const OrderSummaryPage({super.key});

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  final CartActions cartActions = CartActions();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  List<dynamic> cartItems = [];

  String? userEmail;
  String? userPassword;

  @override
  void initState() {
    super.initState();
    // Fetch user credentials from secure storage
    fetchCredentials().then((_) {
      // Fetch cart items using user credentials
      print(
          "userEmail b4 fetch cart called = ${userEmail} and psw = ${userPassword}");
      fetchCart();
    });
  }

  Future<void> fetchCredentials() async {
    userEmail = await secureStorage.read(key: 'email');
    userPassword = await secureStorage.read(key: 'password');
    print(userEmail);
  }

  Future<void> fetchCart() async {
    print("fetch cart started");
    try {
      List<dynamic> fetchedCart =
          await cartActions.fetchCart(userEmail, userPassword);
      setState(() {
        cartItems = fetchedCart;
      });
    } catch (e) {
      // Handle errors if needed
      print('Error fetching cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
            child: Row(
              children: [
                Text("Cart Summary:"),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItemDisplayWidget(
                  cartItem: cartItems[index],
                );
              },
            ),
          ),
          Row(
            children: [
              Text("Send to:"),
            ],
          ),
          Text("Name:"),
          Text("Email:"),
          Text("Address:"),
          Row(
            children: [
              Text("Pay with:"),
            ],
          ),
        ],
      ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Container(
              padding: EdgeInsets.all(8.0),
              color: const Color.fromARGB(255, 61, 56, 56),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order total: \$${calculateTotal()}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle checkout action
                      // You can navigate to a checkout page or perform other actions
                    },
                    child: Text('Proceed to Payment'),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  double calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
