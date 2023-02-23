import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/creator.dart';
import 'package:siksik_labuyo/view/pages/inventory/form/add_creator_form.dart';
import 'package:siksik_labuyo/view/widgets/inventory/creator_card.dart';

class CreatorsTabView extends StatefulWidget {
  const CreatorsTabView({super.key});

  @override
  State<CreatorsTabView> createState() => _CreatorsTabViewState();
}

class _CreatorsTabViewState extends State<CreatorsTabView> with AutomaticKeepAliveClientMixin<CreatorsTabView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: Creator.fetchCollectionFromFirestore().snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var snapshotData = snapshot.data!;
              final creators = snapshotData.docs
                  .map((doc) => Creator.fromJson(doc.data() as Map<String, dynamic>))
                  .toList();
              return SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: creators.map((creator) => CreatorCard(creator: creator)).toList(),
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
            heroTag: 'add_creator_btn',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddCreatorForm()),
              );
            },
            child: const Icon(Icons.person_add),
          ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
