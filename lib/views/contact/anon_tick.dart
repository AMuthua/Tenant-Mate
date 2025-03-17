import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Anonymous Report")),
      body: Center(child: Text("Coming soon, you can now notify the Agents anonymously of any incidences or mishaps")),
    );
  }
}