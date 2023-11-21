import 'package:clients_products_page/providers/app_data.dart';
import 'package:clients_products_page/ui/display_products.dart';
import 'package:clients_products_page/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'ui/login_page.dart';

void main() {
  runApp(AppData(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // final bool isDarkMode = false; //remove in production

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: isDarkMode
      //     ? ThemeData(useMaterial3: true, colorScheme: darkColorScheme)
      //     : ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.system,
      // home: const LoginPage(),
      home: ProductsPage(),
    );
  }
}
