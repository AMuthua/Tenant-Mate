import 'package:tenant_mate_v3/views/auth/auth_service.dart';
import 'package:tenant_mate_v3/pages/register_page.dart';
import 'package:tenant_mate_v3/main.dart'; // Import your HomePage
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Toggle for dark mode
  bool _isDarkMode = false;

  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.SignInWithEmailPassword(email, password);
      // Navigate to HomePage after a successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define colors based on the dark mode state
    final backgroundColor = _isDarkMode ? Colors.grey[900] : Colors.blueGrey[50];
    final textFieldTextColor = _isDarkMode ? Colors.white : Colors.black;
    final labelColor = _isDarkMode ? Colors.white70 : Colors.black54;
    final iconColor = _isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: _isDarkMode ? Colors.black87 : Colors.blue,
        title: const Center(child: Text("Login")),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textFieldTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                style: TextStyle(color: textFieldTextColor),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: labelColor),
                  prefixIcon: Icon(Icons.email, color: iconColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: labelColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: textFieldTextColor),
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: labelColor),
                  prefixIcon: Icon(Icons.lock, color: iconColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: labelColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: _isDarkMode ? Colors.tealAccent[700] : Colors.blue,
                ),
                child: const Text("Login", style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                ),
                child: Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                    fontSize: 16,
                    color: _isDarkMode ? Colors.tealAccent : Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
