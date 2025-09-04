import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rewarity Dashboard')),
      body: const Center(child: Text('Welcome to Rewarity 👋')),
    );
  }
}
