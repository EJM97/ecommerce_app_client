import 'package:clients_products_page/api_calls/cart_actions.dart';
import 'package:flutter/material.dart';
import 'package:clients_products_page/models/cart_item.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartItemDisplayWidget extends StatelessWidget {
  final CartItem cartItem;

  // late VoidCallback onItemUpdated;

  CartItemDisplayWidget({
    required this.cartItem,
  });
  onQuantityChanged(int quantity) async {
    final CartActions cartActions = CartActions();
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    List<dynamic> cartItems = [];

    String? email = await secureStorage.read(key: 'email');
    String? password = await secureStorage.read(key: 'password');
    var productId = cartItem.product.id;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartItem.product.name),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Price: \$${cartItem.product.price}0'),
          Text('Qty: ${cartItem.quantity}'),
          Row(
            children: [
              Text('Subtotal: \$${cartItem.product.price * cartItem.quantity}'),
            ],
          ),
        ],
      ),
    );
  }
}
