// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class GeneralReport extends StatefulWidget {
  const GeneralReport({super.key});

  @override
  State<GeneralReport> createState() => _GeneralReport();
}

class _GeneralReport extends State<GeneralReport> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SafeArea(
          child: Text("General Reports"),
        ),
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        Center(
            child: Text(
          'General Report',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        DataTable(
          columns: [
            DataColumn(
                label: Text('Name',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Profit',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Stephen')),
              DataCell(Text('Morbillion Dollas')),
            ]),
            DataRow(cells: [
              DataCell(Text('John')),
              DataCell(Text('nothing')),
            ]),
            DataRow(cells: [
              DataCell(Text('Harry')),
              DataCell(Text('410 USD')),
            ]),
            DataRow(cells: [
              DataCell(Text('Peter')),
              DataCell(Text('69 USD')),
            ]),
          ],
        ),
      ]),
    );
  }*/
}
