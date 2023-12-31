import 'package:clients_products_page/api_calls/cart_actions.dart';
import 'package:flutter/material.dart';
import 'package:clients_products_page/models/cart_item.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Future<void> Function() onItemUpdate;
  // late VoidCallback onItemUpdated;

  CartItemWidget({
    required this.cartItem,
    required this.onItemUpdate,
  });
  onQuantityChanged(int quantity) async {
    final CartActions cartActions = CartActions();
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    List<dynamic> cartItems = [];
    print(quantity);

    String? email = await secureStorage.read(key: 'email');
    String? password = await secureStorage.read(key: 'password');
    var productId = cartItem.product.id;
    Future<List<CartItem>> updated_cart =
        cartActions.updateQuantity(email, password, productId, quantity);
    await onItemUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartItem.product.name),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Price: \$${cartItem.product.price * cartItem.quantity}'),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => {
                  // null
                  onQuantityChanged(cartItem.quantity - 1)
                },
              ),
              Text('${cartItem.quantity}'),
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => {
                        // null
                        onQuantityChanged((cartItem.quantity + 1)),
                      }),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => {onQuantityChanged(0)},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
