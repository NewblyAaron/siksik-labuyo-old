import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/item.dart';
import 'package:siksik_labuyo/view/pages/inventory/form/add_item_form.dart';
import 'package:siksik_labuyo/view/widgets/inventory/item_card.dart';

class ItemsTabView extends StatefulWidget {
  const ItemsTabView({super.key});

  @override
  State<ItemsTabView> createState() => _ItemTabViewState();
}

class _ItemTabViewState extends State<ItemsTabView> with AutomaticKeepAliveClientMixin<ItemsTabView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: Item.fetchCollectionFromFirestore().snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var snapshotData = snapshot.data!;
              final items = snapshotData.docs
                  .map((doc) => Item.fromJson(doc.data() as Map<String, dynamic>))
                  .toList();
              return SafeArea(
                child: GridView.count(
                  crossAxisCount: 2,
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
          floatingActionButton: FloatingActionButton(
            heroTag: 'add_item_btn',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddItemForm())
              );
            },
            child: const Icon(Icons.add),
          ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
