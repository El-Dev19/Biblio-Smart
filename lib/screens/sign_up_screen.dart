import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/books_list_screen.dart';
import 'package:myapp/screens/sign_in_screen.dart';
// import 'package:myapp/screens/sign_up_screen.dart';
import 'package:myapp/widgets/custom_button.dart';
import 'package:myapp/widgets/custom_textfield.dart';
import 'package:myapp/widgets/validators.dart';

/// Écran Sign In basique simulé avec SharedPreferences

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    final _auth = FirebaseAuth.instance;

    Future<void> _signUp() async {
      try{
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
       );
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compte créé avec succès !')),
      );
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignInScreen()),
      );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign Up", style: Theme.of(context).textTheme.displayLarge),
              SizedBox(height: 24),
              CustomTextField(
                hintText: "Email",
                controller: _emailController,
                validator: Validators.validateEmail,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: "Password",
                controller: _passwordController,
                validator: Validators.validatePassword,
                obscureText: true,
              ),
              SizedBox(height: 24),
              CustomButton(
                label: "Sign Up", 
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signUp();
                  }
                }),
            ],
          ),
        ),
      ),
    );
  }
}


