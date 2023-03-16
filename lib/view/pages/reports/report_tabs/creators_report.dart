import 'package:flutter/material.dart';

class CreatorsReport extends StatefulWidget {
  const CreatorsReport({super.key});

  @override
  State<CreatorsReport> createState() => _CreatorsReport();
}

class _CreatorsReport extends State<CreatorsReport> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SafeArea(
          child: Text("Creator Reports"),
        ),
      ),
    );
  }
}
