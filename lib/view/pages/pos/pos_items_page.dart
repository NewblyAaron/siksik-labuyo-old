import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/item.dart';
import 'package:siksik_labuyo/view/widgets/inventory/item_card.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: itemsRef.reference.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var snapshotData = snapshot.data!;
              final items = snapshotData.docs
                  .map((doc) => doc.data())
                  .toList();
              return SafeArea(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  padding: const EdgeInsets.all(8),
                  children: items.map((item) => ItemCard(item: item)).toList(),
                ),
              );
            } else {
              return const SafeArea(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}