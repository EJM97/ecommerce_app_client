import 'package:clients_products_page/models/cart_item.dart';

class Cart {
  List<CartItem> cartItems;

  Cart({required this.cartItems});

  factory Cart.fromJson(List<dynamic> json) {
    List<CartItem> cartItems =
        json.map((item) => CartItem.fromJson(item)).toList();

    return Cart(cartItems: cartItems);
  }

  Map<String, dynamic> toJson() {
    return {
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
    };
  }
}
