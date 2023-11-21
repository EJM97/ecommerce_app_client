import 'package:clients_products_page/api_calls/auth.dart';
import 'package:clients_products_page/providers/app_data.dart';
import 'package:clients_products_page/ui/register_page.dart';
import 'package:clients_products_page/widgets/input_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Get the email and password from the controllers
      final email = emailController.text;
      final password = passwordController.text;
      final Auth auth = Auth();

      // Call the authentication function and wait for the result
      final user = await auth.login(email, password);
      print(user);

      if (user != null) {
        // Authentication successful, you can navigate to another page or perform other actions.
        // Navigate to the sign-up page when the text is clicked
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Placeholder(); // Replace with post login page
        }));
      } else {
        // Authentication failed, show an error message to the user.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your credentials.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppData(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                if (passwordError != null)
                  Text(
                    passwordError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ElevatedButton(
                  onPressed: submitForm,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    // Navigate to the sign-up page when the text is clicked
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return RegisterPage(); // Replace with your sign-up page widget
                    }));
                  },
                  child: Text(
                    "Don't have an account? Sign up",
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
