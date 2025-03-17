// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:intl/intl.dart';
// // import 'package:tenant_mate_v3/views/auth/auth_service.dart';
// // import 'package:tenant_mate_v3/pages/login_page.dart';
// // import 'package:supabase_flutter/supabase_flutter.dart';

// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({super.key});

// //   @override
// //   State<ProfilePage> createState() => _ProfilePageState();
// // }

// // class _ProfilePageState extends State<ProfilePage> {
// //   final authService = AuthService();
// //   late Map<String, dynamic> _userData = {};
// //   bool _isLoading = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchUserData();
// //   }

// //   Future<void> _fetchUserData() async {
// //     final supabase = Supabase.instance.client;
// //     final user = supabase.auth.currentUser;

// //     if (user != null) {
// //       try {
// //         final response = await supabase
// //             .from('tenants')
// //             .select('username, email, house_number, rent_due_date, rent_status, rent_amount')
// //             .eq('id', user.id)
// //             .single();

// //         setState(() {
// //           _userData = response;
// //           _isLoading = false;
// //         });
// //       } catch (e) {
// //         setState(() {
// //           _isLoading = false;
// //         });
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Error fetching profile data: $e")),
// //         );
// //       }
// //     } else {
// //       setState(() {
// //         _isLoading = false;
// //       });
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("User not logged in")),
// //       );
// //     }
// //   }

// //   void logout() async {
// //     await authService.signOut();
// //     Navigator.pushReplacement(
// //       context,
// //       MaterialPageRoute(builder: (context) => const LoginPage()),
// //     );
// //   }

// //    @override
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Profile"),
// //         actions: [
// //           IconButton(
// //             onPressed: logout,
// //             icon: const Icon(Icons.logout),
// //           ),
// //         ],
// //       ),
// //       body: _isLoading
// //           ? const Center(child: CircularProgressIndicator())
// //           : Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: ListView(
// //                 children: [
// //                   // Top Up Card
// //                   Card(
// //                     elevation: 4,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(16.0),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           _buildDetailRow(Icons.payment, "Paybill", _userData['paybill']),
// //                           _buildDetailRow(Icons.account_balance, "Account Number", _userData['account_number']),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 16),
// //                   // User Details Cards
// //                   _buildProfileCard(Icons.person, "Username", _userData['username']),
// //                   _buildProfileCard(Icons.email, "Email", _userData['email']),
// //                   _buildProfileCard(Icons.home, "House Number", _userData['house_number']),
// //                   _buildProfileCard(Icons.calendar_today, "Rent Due Date", _userData['rent_due_date']),
                  
// //                 ],
// //               ),
// //             ),
// //     );
// //   }

// //   Widget _buildProfileCard(IconData icon, String title, String? value) {
// //     String displayValue = value ?? 'Client';
// //   if (title == "Rent Due Date" && value != null) {
// //     try {
// //       DateTime date = DateTime.parse(value);
// //       displayValue = DateFormat.yMMMd().format(date); // Format the date
// //     } catch (e) {
// //       print("Error formatting date: $e");
// //     }
// //   }
    
// //     return Card(
// //       elevation: 2,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// //       margin: const EdgeInsets.only(bottom: 8),
// //       child: ListTile(
// //         leading: Icon(icon, color: Colors.orangeAccent),
// //         title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
// //         subtitle: Text(value ?? 'Client'), // Change N/A to Client
// //       ),
// //     );
// //   }

// //   Widget _buildDetailRow(IconData icon, String title, String? value) {
// //     return Row(
// //       children: [
// //         Icon(icon, color: Colors.green),
// //         const SizedBox(width: 8),
// //         Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
// //         Text(value ?? 'Client'), // Change N/A to Client
// //         IconButton(
// //           onPressed: () {
// //             Clipboard.setData(ClipboardData(text: value ?? 'Client')); // Change N/A to Client
// //             ScaffoldMessenger.of(context).showSnackBar(
// //                 SnackBar(content: Text("$title copied")));
// //           },
// //           icon: const Icon(Icons.copy),
// //         ),
// //       ],
// //     );
// //   }
// // }




// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:tenant_mate_v3/views/auth/auth_service.dart';
// import 'package:tenant_mate_v3/pages/login_page.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final authService = AuthService();
//   late Map<String, dynamic> _userData = {};
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//   }

//   Future<void> _fetchUserData() async {
//     final supabase = Supabase.instance.client;
//     final user = supabase.auth.currentUser;

//     if (user != null) {
//       try {
//         final response = await supabase
//             .from('tenants')
//             .select('username, email, house_number, rent_due_date')
//             .eq('id', user.id)
//             .single();

//         setState(() {
//           _userData = response;
//           _isLoading = false;
//         });
//       } catch (e) {
//         setState(() {
//           _isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error fetching profile data: $e")),
//         );
//       }
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("User not logged in")),
//       );
//     }
//   }

//   void logout() async {
//     await authService.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//         actions: [
//           IconButton(
//             onPressed: logout,
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ListView(
//                 children: [
//                   _buildProfileCard(Icons.person, "Username", _userData['username']),
//                   _buildProfileCard(Icons.email, "Email", _userData['email']),
//                   _buildProfileCard(Icons.home, "House Number", _userData['house_number']),
//                   _buildProfileCard(Icons.calendar_today, "Rent Due Date", _userData['rent_due_date']),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildProfileCard(IconData icon, String title, String? value) {
//     String displayValue = value ?? 'Client';
//     if (title == "Rent Due Date" && value != null) {
//       try {
//         DateTime date = DateTime.parse(value);
//         displayValue = DateFormat.yMMMd().format(date);
//       } catch (e) {
//         print("Error formatting date: $e");
//       }
//     }

//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.orangeAccent),
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(displayValue),
//       ),
//     );
//   }
// }


// test II

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
            .select('username, email, house_number, rent_due_date, created_at') // Include created_at
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
              child: ListView(
                children: [
                  _buildProfileCard(Icons.person, "Username", _userData['username']),
                  _buildProfileCard(Icons.email, "Email", _userData['email']),
                  _buildProfileCard(Icons.home, "House Number", _userData['house_number']),
                  _buildProfileCard(Icons.calendar_today, "Rent Due Date", _calculateDueDate()),
                ],
              ),
            ),
    );
  }

  String _calculateDueDate() {
    if (_userData['created_at'] != null) {
      try {
        DateTime createdAt = DateTime.parse(_userData['created_at']);
        DateTime dueDate = createdAt.add(const Duration(days: 30));
        return DateFormat.yMMMd().format(dueDate);
      } catch (e) {
        print("Error calculating due date: $e");
        return "Error";
      }
    } else {
      return "N/A";
    }
  }

  Widget _buildProfileCard(IconData icon, String title, String? value) {
    String displayValue = value ?? 'Client';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.orangeAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(displayValue),
      ),
    );
  }
}