import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (_) => const HomeScreen());
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
