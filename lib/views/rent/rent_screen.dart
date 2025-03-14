import 'package:flutter/material.dart';

class RentScreen extends StatelessWidget {
  final String tenantName;
  final String houseNumber;
  final double rentAmount;
  final String dueDate;
  final String status;

  const RentScreen({
    super.key,
    required this.tenantName,
    required this.houseNumber,
    required this.rentAmount,
    required this.dueDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rent Payment Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
                    Text("Tenant Name:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(tenantName, style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text("House Number:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(houseNumber, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
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
                    Text("Rent Amount:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("Ksh ${rentAmount.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text("Due Date:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(dueDate, style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text("Status:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(status, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Payment functionality not implemented")),
                );
              },
              child: const Text('Pay Rent'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}