import 'package:flutter/material.dart';
import 'views/auth/maintenance/maintenance_screen.dart'; // Import the maintenance screen

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
      home: HomeScreen(), // Change to HomeScreen
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TenantMate Users Dashboard")),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            tileColor: Colors.blueAccent.withOpacity(0.1),
            leading: Icon(Icons.build, color: Colors.blueAccent),
            title: Text("Maintenance Ticketing"),
            subtitle: Text("Submit maintenance requests & track status"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MaintenanceScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
