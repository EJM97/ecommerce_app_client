import 'package:clients_products_page/providers/app_data.dart';
import 'package:clients_products_page/ui/display_products.dart';
import 'package:clients_products_page/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'ui/login_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Check if email and password exist in secure storage
  String? email = await secureStorage.read(key: 'email');
  String? password = await secureStorage.read(key: 'password');
  runApp(AppData(child: MainApp(email: email, password: password)));
}

class MainApp extends StatelessWidget {
  final String? email;
  final String? password;
  const MainApp({super.key, this.email, this.password});
  // final bool isDarkMode = false; //remove in production
  @override
  Widget build(BuildContext context) {
    if (email != null && password != null) {
      return MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        themeMode: ThemeMode.system,
        // home: const LoginPage(),
        home: ProductsPage(),
      );
    } else {
      return MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        themeMode: ThemeMode.system,
        home: const LoginPage(),
        // home: ProductsPage(),
      );
    }
  }
}
