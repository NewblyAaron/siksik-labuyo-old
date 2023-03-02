import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/category.dart';
import 'package:siksik_labuyo/view/pages/inventory/form/add_category_form.dart';
import 'package:siksik_labuyo/view/widgets/inventory/category_card.dart';

class CategoriesTabView extends StatefulWidget {
  const CategoriesTabView({super.key});

  @override
  State<CategoriesTabView> createState() => _CategoriesTabViewState();
}

class _CategoriesTabViewState extends State<CategoriesTabView> with AutomaticKeepAliveClientMixin<CategoriesTabView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Scaffold(
      body: StreamBuilder<CategoryQuerySnapshot>(
          stream: categoriesRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var snapshotData = snapshot.data!;
              final categories = snapshotData.docs
                  .map((doc) => doc.data)
                  .toList();
              return SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: categories.map((category) => CategoryCard(category: category)).toList(),
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
            heroTag: 'add_category_btn',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddCategoryForm())
              );
            },
            child: const Icon(Icons.playlist_add),
          ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
