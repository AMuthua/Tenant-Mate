import 'package:flutter/material.dart';
import 'package:tenantmate/views/auth/login_screen.dart';
import 'package:tenantmate/views/contact/support.dart';
import 'views/auth/maintenance/maintenance_screen.dart';
import 'views/profile/profile_screen.dart';
import 'views/rent/rent_screen.dart';

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
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: LoginScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample rent status (replace with actual data from backend)
  String rentStatus = "Due";
  double rentAmount = 500.00;

  // Sample maintenance requests (Replace with actual database values)
  List<Map<String, String>> maintenanceRequests = [
    {"issue": "Leaking pipe", "status": "Pending"},
    {"issue": "Broken AC", "status": "In Progress"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TenantMate Dashboard")),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rent Status Card
            _buildRentStatusCard(),
            SizedBox(height: 20),
            // Maintenance Requests List
            _buildMaintenanceRequests(),
          ],
        ),
      ),
    );
  }

  // Side Panel Drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money, color: Colors.green),
            title: Text("Rent Payment"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RentScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.build, color: Colors.orange),
            title: Text("Maintenance"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MaintenanceScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_support, color: Colors.red),
            title: Text("Report App Issues"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SupportScreen()));
            },
          ),
        ],
      ),
    );
  }

  // Rent Status Widget
  Widget _buildRentStatusCard() {
    Color statusColor = rentStatus == "Paid"
        ? Colors.green
        : rentStatus == "Overdue"
            ? Colors.red
            : Colors.orange;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rent Status", style: TextStyle(fontSize: 16)),
                SizedBox(height: 5),
                Text("\$${rentAmount.toStringAsFixed(2)} Due",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(rentStatus, style: TextStyle(fontSize: 16, color: statusColor)),
              ],
            ),
            Icon(Icons.home, color: statusColor, size: 40),
          ],
        ),
      ),
    );
  }

  // Maintenance Requests List
  Widget _buildMaintenanceRequests() {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Maintenance Requests", style: TextStyle(fontSize: 16)),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: maintenanceRequests.length,
                  itemBuilder: (context, index) {
                    var request = maintenanceRequests[index];
                    Color statusColor = request["status"] == "Completed"
                        ? Colors.green
                        : request["status"] == "In Progress"
                            ? Colors.orange
                            : Colors.red;

                    return ListTile(
                      title: Text(request["issue"]!),
                      subtitle: Text(request["status"]!,
                          style: TextStyle(color: statusColor)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
