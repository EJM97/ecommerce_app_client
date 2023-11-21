import 'package:clients_products_page/api_calls/get_products.dart';
import 'package:flutter/material.dart';
import 'package:clients_products_page/models/product.dart';
import 'package:clients_products_page/widgets/product_widget.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch products when the page is loaded
    fetchProducts().then((productList) {
      setState(() {
        products = productList.productList; // Extract the list of products
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: isLoading
          ? Center(
              // Display circular progress indicator while loading
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductWidget(product: products[index]);
              },
            ),
    );
  }
}
