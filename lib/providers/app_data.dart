import 'package:flutter/material.dart';

class AppData extends InheritedWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AppData({required Widget child}) : super(child: child);

  static AppData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppData>()!;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
