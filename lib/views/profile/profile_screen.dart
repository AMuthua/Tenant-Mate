import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tenant_mate_v3/views/auth/auth_service.dart';
import 'package:tenant_mate_v3/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();
  late Map<String, dynamic> _userData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user != null) {
      try {
        final response = await supabase
            .from('tenants')
            .select('username, email, house_number, rent_due_date, rent_status, rent_amount')
            .eq('id', user.id)
            .single();

        setState(() {
          _userData = response;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching profile data: $e")),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
    }
  }

  void logout() async {
    await authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Up Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Paybill: ${_userData['paybill'] ?? 'N/A'}",
                              style: const TextStyle(fontSize: 18)),
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                  text: _userData['paybill'] ?? ''));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Paybill copied")));
                            },
                            icon: const Icon(Icons.copy),
                          ),
                          Text(
                              "Account Number: ${_userData['account_number'] ?? 'N/A'}",
                              style: const TextStyle(fontSize: 18)),
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                  text: _userData['account_number'] ?? ''));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Account number copied")));
                            },
                            icon: const Icon(Icons.copy),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // User Details
                  Text("Username: ${_userData['username'] ?? 'N/A'}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Email: ${_userData['email'] ?? 'N/A'}",
                      style: const TextStyle(fontSize: 18)),
                  Text("House Number: ${_userData['house_number'] ?? 'N/A'}",
                      style: const TextStyle(fontSize: 18)),
                  // ... (other details) ...
                ],
              ),
            ),
    );
  }
}