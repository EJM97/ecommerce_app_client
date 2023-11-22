import 'package:clients_products_page/api_calls/cart_actions.dart';
import 'package:flutter/material.dart';
import 'package:clients_products_page/models/cart_item.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;
  // final Function(int) onQuantityChanged;
  // final Function() onRemove;

  CartItemWidget({
    required this.cartItem,
    // required this.onQuantityChanged,
    // required this.onRemove,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.cartItem.product.name),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              'Price: \$${widget.cartItem.product.price * widget.cartItem.quantity}'),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => {
                  // null
                  onQuantityChanged(widget.cartItem.quantity - 1)
                },
              ),
              Text('${widget.cartItem.quantity}'),
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => {
                        // null
                        onQuantityChanged(widget.cartItem.quantity + 1),
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

  onQuantityChanged(int quantity) async {
    final CartActions cartActions = CartActions();
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    List<dynamic> cartItems = [];

    String? email = await secureStorage.read(key: 'email');
    String? password = await secureStorage.read(key: 'password');
    var productId = widget.cartItem.product.id;
    Future<List<CartItem>> updated_cart =
        cartActions.updateQuantity(email, password, productId, quantity);
  }
}
