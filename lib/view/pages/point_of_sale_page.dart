import 'package:flutter/material.dart';

class PointOfSalePage extends StatefulWidget {
  const PointOfSalePage({super.key});
  
  @override
  State<PointOfSalePage> createState() => _PointOfSalePageState();
}

class _PointOfSalePageState extends State<PointOfSalePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SafeArea(
          child: Text("Point of Sale"),
        ),
      ),
    );
  }
}