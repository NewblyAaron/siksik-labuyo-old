import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/item.dart';
import 'package:siksik_labuyo/view/pages/inventory/form/add_item_form.dart';
import 'package:siksik_labuyo/view/widgets/inventory/new_item_card.dart';

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
      body: StreamBuilder<QuerySnapshot<Item>>(
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
                  children: items.map((item) => NewItemCard(item: item)).toList(),
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
