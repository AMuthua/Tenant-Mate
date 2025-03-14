import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tenant_mate_v3/views/rent/keys.dart';

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
                await _initiateMpesaPayment(context, rentAmount, "254726108225");
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

  Future<void> _initiateMpesaPayment(BuildContext context, double amount, String phone) async {
    try {
      // Set your consumer key and secret (do this only once, e.g., in your main() or initState())
      MpesaFlutterPlugin.setConsumerKey(kConsumerKey);
      MpesaFlutterPlugin.setConsumerSecret(kConsumerSecret);

      dynamic transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: amount, // Amount as string
        partyA: "254726108225", // Tenant's phone number
        partyB: "174379",
        callBackURL: Uri(
                  scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
        accountReference: "Rent Payment",
        phoneNumber: "254726108225", // Tenant's phone number
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"), // Or MpesaFlutterPlugin.liveURL
        transactionDesc: 'Rent Payment Demo',
        passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
      );

      print('M-Pesa response: $transactionInitialisation');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("M-Pesa request initiated. Check your phone.")),
      );
    } catch (e) {
      print('M-Pesa error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error initiating M-Pesa: $e")),
      );
    }
  }

}