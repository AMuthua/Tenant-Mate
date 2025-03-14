import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

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
              onPressed: () async {
                await _initiateMpesaPayment(context, rentAmount);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Pay Rent'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initiateMpesaPayment(BuildContext context, double amount) async {
    final url = Uri.parse('YOUR_MPESA_API_ENDPOINT'); // Replace with your M-Pesa API endpoint
    final consumerKey = 'YOUR_CONSUMER_KEY'; // Replace with your consumer key
    final consumerSecret = 'YOUR_CONSUMER_SECRET'; // Replace with your consumer secret
    final phoneNumber = 'YOUR_PHONE_NUMBER'; // Replace with the tenant's phone number
    final businessShortCode = 'YOUR_BUSINESS_SHORTCODE'; // Replace with your business shortcode

    try {
      final auth = base64Encode(utf8.encode('$consumerKey:$consumerSecret'));
      final authResponse = await http.get(
        Uri.parse('YOUR_MPESA_AUTH_ENDPOINT'), // Replace with your M-Pesa auth endpoint
        headers: {'Authorization': 'Basic $auth'},
      );

      if (authResponse.statusCode == 200) {
        final authToken = json.decode(authResponse.body)['access_token'];

        final timestamp = DateTime.now().toIso8601String().replaceAll(RegExp(r'[-:.]'), '');
        final password = base64Encode(utf8.encode('$businessShortCode$consumerKey$timestamp'));

        final body = json.encode({
          "BusinessShortCode": 174379,
          "Password": password,
          "Timestamp": timestamp,
          "TransactionType": "CustomerPayBillOnline",
          "Amount": amount.toInt(),
          "PartyA": phoneNumber,
          "PartyB": businessShortCode,
          "PhoneNumber": phoneNumber,
          "CallBackURL": "YOUR_CALLBACK_URL", // Replace with your callback URL
          "AccountReference": "Rent Payment",
          "TransactionDesc": "Rent Payment",
        });

        final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
          body: body,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("M-Pesa request initiated. Check your phone.")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("M-Pesa request failed: ${response.body}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("M-Pesa auth failed: ${authResponse.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error initiating M-Pesa: $e")),
      );
    }
  }

}