import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.logout),
        ),
      ),
    );
  }
}
