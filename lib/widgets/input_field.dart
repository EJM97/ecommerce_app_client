import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final void Function(String) onChanged;

  const InputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        obscureText: hint.toLowerCase().contains('password'),
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          focusColor: Theme.of(context).colorScheme.primary,
          hintText: hint,
        ),
      ),
    );
  }
}
