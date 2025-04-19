import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final user = await authService.signIn(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                    if (user != null) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login failed')),
                      );
                    }
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}