import 'package:clients_products_page/api_calls/auth.dart';
import 'package:clients_products_page/providers/app_data.dart';
import 'package:clients_products_page/ui/login_page.dart';
import 'package:clients_products_page/widgets/input_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  String? nameError;
  String? emailError;
  String? passwordError;

  void validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        emailError = 'Email is required';
      });
    } else if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(value)) {
      setState(() {
        emailError = 'Email is invalid';
      });
    } else {
      setState(() {
        emailError = null;
      });
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        passwordError = 'Password is required';
      });
    } else {
      setState(() {
        passwordError = null;
      });
    }
  }

  void validatePasswordConfirm(String value) {
    final password = passwordController.text;
    if (value != password) {
      setState(() {
        passwordError = 'Passwords don\'t match';
      });
    } else {
      setState(() {
        passwordError = null;
      });
    }
  }

  void validateName(String value) {
    if (value.isEmpty) {
      setState(() {
        nameError = 'Name is required';
      });
    } else {
      setState(() {
        nameError = null;
      });
    }
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Get the email and password from the controllers
      final name = nameController.text;
      final email = emailController.text;
      final password = passwordController.text;
      final Auth auth = Auth();

      // Call the authentication function and wait for the result
      final user = await auth.register(name, email, password);
      print(user);

      if (user == "Registered Successfully") {
        // Registration successful, you can navigate to another page or perform other actions.
        // navigate to login??? orr login automatically
      } else {
        // Registration failed, show an error message to the user.
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${user}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppData(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register Page'),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InputField(
                  controller: nameController,
                  hint: 'Name',
                  onChanged: validateName, // Call the validation function
                ),
                InputField(
                  controller: emailController,
                  hint: 'Email',
                  onChanged: validateEmail, // Call the validation function
                ),
                if (emailError != null)
                  Text(
                    emailError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                InputField(
                  controller: passwordController,
                  hint: 'Password',
                  onChanged: validatePassword, // Call the validation function
                ),
                InputField(
                  controller: passwordConfirmController,
                  hint: 'Confirm Password',
                  onChanged:
                      validatePasswordConfirm, // Call the validation function
                ),
                if (passwordError != null)
                  Text(
                    passwordError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ElevatedButton(
                  onPressed: submitForm,
                  child: const Text('Register'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    // Navigate to the sign-up page when the text is clicked
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const LoginPage(); // Replace with your sign-up page widget
                    }));
                  },
                  child: Text(
                    "Already have an account? Log in.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
