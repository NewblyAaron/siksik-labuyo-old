import 'package:flutter/material.dart';

class CreatorsReport extends StatefulWidget {
  const CreatorsReport({super.key});

  @override
  State<CreatorsReport> createState() => _CreatorsReport();
}

class _CreatorsReport extends State<CreatorsReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        const Center(
            child: Text(
          'Creator Report',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        DataTable(
          columns: const [
            DataColumn(
                label: Text('Name',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Profit',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ],
          rows: const [
            DataRow(cells: [
              DataCell(Text('Stephen')),
              DataCell(Text('6 500 Php')),
            ]),
            DataRow(cells: [
              DataCell(Text('John')),
              DataCell(Text('1 000 Php')),
            ]),
            DataRow(cells: [
              DataCell(Text('Harry')),
              DataCell(Text('500 Php')),
            ]),
            DataRow(cells: [
              DataCell(Text('Peter')),
              DataCell(Text('2 000 Php')),
            ]),
          ],
        ),
      ]),
    );
  }
}
