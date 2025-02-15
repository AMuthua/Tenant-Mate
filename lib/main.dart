import 'package:flutter/material.dart';
import 'views/auth/maintenance/maintenance_screen.dart';
import 'views/profile/profile_screen.dart';  // Import Profile Screen
import 'views/rent/rent_screen.dart';        // Import Rent Screen

void main() {
  runApp(TenantMateApp());
}

class TenantMateApp extends StatelessWidget {
  const TenantMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TenantMate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TenantMate Dashboard")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle, size: 64, color: Colors.white),
                  SizedBox(height: 10),
                  Text("Welcome, Tenant!",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blueAccent),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money, color: Colors.green),
              title: Text("Rent Payment"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RentScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.build, color: Colors.orange),
              title: Text("Maintenance"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MaintenanceScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "Welcome to TenantMate",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
