import 'package:clients_products_page/models/product.dart';

class Products {
  List<Product> productList;

  Products(this.productList);

  // Sort products by price in ascending order
  void sortProductsByPriceAsc() {
    productList.sort((a, b) => a.price.compareTo(b.price));
  }

  // Sort products by price in descending order
  void sortProductsByPriceDesc() {
    productList.sort((a, b) => b.price.compareTo(a.price));
  }
}
