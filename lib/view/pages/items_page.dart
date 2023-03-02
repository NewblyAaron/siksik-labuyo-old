import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SafeArea(
          child: Text("Items Page"),
        ),
      ),
    );
  }
}