import 'package:flutter/material.dart';

class GeneralReport extends StatefulWidget {
  const GeneralReport({super.key});

  @override
  State<GeneralReport> createState() => _GeneralReport();
}

class _GeneralReport extends State<GeneralReport> {
  /*@override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SafeArea(
          child: Text("General Reports"),
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        const Center(
            child: Text(
          'General Report',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        DataTable(
          columns: const [
            DataColumn(
                label: Text('',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ],
          rows: const [
            DataRow(cells: [
              DataCell(Text('Total Profit')),
              DataCell(Text('10 000 Php')),
            ]),
            DataRow(cells: [
              DataCell(Text('Most Selling Product')),
              DataCell(Text('Smug Anya')),
            ]),
            DataRow(cells: [
              DataCell(Text('Top Selling Creator')),
              DataCell(Text('Stephen')),
            ])
          ],
        ),
      ]),
    );
  }
}
