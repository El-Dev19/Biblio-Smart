import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/widgets/custom_button.dart';
import 'package:myapp/widgets/custom_textfield.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Créer un compte')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Inscription",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 24),
              CustomTextField(
                hintText: "Email",
                controller: _emailController,
                validator:
                    (value) => value!.isEmpty ? 'Entrez votre email' : null,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: "Email",
                controller: _passwordController,
                validator:
                    (value) => value!.isEmpty ? 'Entrez votre Password' : null,
              ),
              const SizedBox(height: 24),
              CustomButton(
                label: "Connexion",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signUp();
                  }
                },
                child: const Text('Creer le compte'),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       _signUp();
              //     }
              //   },
              //   child: const Text('Créer le compte'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
