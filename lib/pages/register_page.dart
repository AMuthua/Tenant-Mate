// import 'package:tenant_mate_v3/views/auth/auth_service.dart';
// import 'package:tenant_mate_v3/pages/login_page.dart'; // Import your LoginPage
// import 'package:flutter/material.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final authService = AuthService();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   // Dark mode toggle
//   bool _isDarkMode = false;

//   void signUp() async {
//     final email = _emailController.text;
//     final password = _passwordController.text;
//     final confirmPassword = _confirmPasswordController.text;

//     if (password != confirmPassword) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Passwords don't match")),
//       );
//       return;
//     }

//     try {
//       await authService.signUpWithEmailPassword(email, password);
//       // Navigate to the LoginPage instead of simply popping
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Error: $e")));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Define colors based on dark mode state
//     final backgroundColor = _isDarkMode ? Colors.grey[900] : Colors.blueGrey[50];
//     final textFieldTextColor = _isDarkMode ? Colors.white : Colors.black;
//     final labelColor = _isDarkMode ? Colors.white70 : Colors.black54;
//     final iconColor = _isDarkMode ? Colors.white : Colors.black;

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: _isDarkMode ? Colors.black87 : Colors.blue,
//         title: const Text("Register"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 _isDarkMode = !_isDarkMode;
//               });
//             },
//             icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
//           )
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   "Create an Account",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: textFieldTextColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: _emailController,
//                   style: TextStyle(color: textFieldTextColor),
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                     labelStyle: TextStyle(color: labelColor),
//                     prefixIcon: Icon(Icons.email, color: iconColor),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: labelColor),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   style: TextStyle(color: textFieldTextColor),
//                   decoration: InputDecoration(
//                     labelText: "Password",
//                     labelStyle: TextStyle(color: labelColor),
//                     prefixIcon: Icon(Icons.lock, color: iconColor),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: labelColor),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 TextField(
//                   controller: _confirmPasswordController,
//                   obscureText: true,
//                   style: TextStyle(color: textFieldTextColor),
//                   decoration: InputDecoration(
//                     labelText: "Confirm Password",
//                     labelStyle: TextStyle(color: labelColor),
//                     prefixIcon: Icon(Icons.lock_outline, color: iconColor),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: labelColor),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: signUp,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     backgroundColor:
//                         _isDarkMode ? Colors.tealAccent[700] : Colors.blue,
//                   ),
//                   child: const Text("Register", style: TextStyle(fontSize: 18)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




// Test 2

import 'package:tenant_mate_v3/views/auth/auth_service.dart';
import 'package:tenant_mate_v3/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController(); // Added username controller
  final _houseNumberController = TextEditingController(); // Added house number controller

  bool _isDarkMode = false;

  Future<void> signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final username = _usernameController.text; // Get username
    final houseNumber = _houseNumberController.text; // Get house number

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords don't match")),
      );
      return;
    }

    try {
      final supabase = Supabase.instance.client;

      final AuthResponse res =
          await supabase.auth.signUp(email: email, password: password);
      final user = res.user;

      if (user != null) {
        await supabase.from('tenants').insert({
          'id': user.id,
          'email': email,
          'username': username,
          'house_number': houseNumber,
          'rent_due_date': '2025-02-01',
          'rent_status': 'Paid',
          'rent_amount': 500.00,
          'created_at': DateTime.now().toUtc().toIso8601String(), // Add this!
        });

        // Navigate to the LoginPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isDarkMode ? Colors.grey[900] : Colors.blueGrey[50];
    final textFieldTextColor = _isDarkMode ? Colors.white : Colors.black;
    final labelColor = _isDarkMode ? Colors.white70 : Colors.black54;
    final iconColor = _isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: _isDarkMode ? Colors.black87 : Colors.blue,
        title: const Text("Register"),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Create an Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textFieldTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _usernameController, // Username TextField
                  style: TextStyle(color: textFieldTextColor),
                  decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(color: labelColor),
                    prefixIcon: Icon(Icons.person, color: iconColor),
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
                  controller: _houseNumberController, // House Number TextField
                  style: TextStyle(color: textFieldTextColor),
                  decoration: InputDecoration(
                    labelText: "House Number",
                    labelStyle: TextStyle(color: labelColor),
                    prefixIcon: Icon(Icons.home, color: iconColor),
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
                const SizedBox(height: 15),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: TextStyle(color: textFieldTextColor),
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: labelColor),
                    prefixIcon: Icon(Icons.lock_outline, color: iconColor),
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
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor:
                        _isDarkMode ? Colors.tealAccent[700] : Colors.blue,
                  ),
                  child: const Text("Register", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}