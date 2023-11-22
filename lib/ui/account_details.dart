import 'package:clients_products_page/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountItemWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  AccountItemWidget(
      {required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                SizedBox(width: 16.0),
                Text(text),
              ],
            ),
            Icon(Icons.arrow_forward_ios), // ">" icon
          ],
        ),
      ),
    );
  }
}

class AccountDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
      ),
      body: ListView(
        children: [
          AccountItemWidget(
            icon: Icons.account_circle,
            text: 'Account Details',
            onTap: () {
              // Navigate to the account details page
              // Navigator.pushNamed(context, null);
            },
          ),
          AccountItemWidget(
            icon: Icons.history,
            text: 'Previous Orders',
            onTap: () {
              // Navigate to the previous orders page
              // Navigator.pushNamed(context, '/previous_orders');
            },
          ),
          AccountItemWidget(
            icon: Icons.payment,
            text: 'Payment Methods',
            onTap: () {
              // Navigate to the payment methods page
              // Navigator.pushNamed(context, '/payment_methods');
            },
          ),
          AccountItemWidget(
            icon: Icons.location_on,
            text: 'Saved Addresses',
            onTap: () {
              // Navigate to the saved addresses page
              // Navigator.pushNamed(context, '/saved_addresses');
            },
          ),
          AccountItemWidget(
            icon: Icons.exit_to_app,
            text: 'Log Out',
            onTap: () async {
              // Perform logout
              final FlutterSecureStorage secureStorage = FlutterSecureStorage();
              await secureStorage.delete(key: 'email');
              await secureStorage.delete(key: 'password');

              // Navigate to login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          AccountItemWidget(
            icon: Icons.delete,
            text: 'Delete Account',
            onTap: () {
              // Delete account functionality
            },
          ),
        ],
      ),
    );
  }
}
