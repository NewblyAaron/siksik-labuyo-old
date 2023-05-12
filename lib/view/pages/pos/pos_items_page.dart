import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/item.dart';
import 'package:siksik_labuyo/view/pages/pos/pos_cart_page.dart';
import 'package:siksik_labuyo/view/widgets/inventory/item_card.dart';

class PointOfSalePage extends StatefulWidget {
  const PointOfSalePage({super.key});

  @override
  State<PointOfSalePage> createState() => _PointOfSalePageState();
}

class _PointOfSalePageState extends State<PointOfSalePage> {
  List<CartItem> cart = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: itemsRef.reference.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var snapshotData = snapshot.data!;
              final items = snapshotData.docs
                  .map((doc) => doc.data())
                  .toList();
              return SafeArea(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ItemCard(item: items[index]);
                  },
                  padding: const EdgeInsets.all(8),
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