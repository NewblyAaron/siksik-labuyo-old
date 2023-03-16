import 'package:flutter/material.dart';
import 'package:siksik_labuyo/view/pages/inventory/tabview/categories_view.dart';
import 'package:siksik_labuyo/view/pages/inventory/tabview/creators_view.dart';
import 'package:siksik_labuyo/view/pages/inventory/tabview/items_view.dart';

/*
  Aaron Serrano
  Team: IDK
  Project: Siksik Labuyo
  Feature: [LBYO - 400] Inventory Page
  Feature Description:
    The page UI for the inventory section of the app. Has tabs to manage different types of data, such as items, categories, and creators.
 */

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> tabs = <Tab>[
    Tab(
        icon: Icon(Icons.sell),
        text: "Items",
        iconMargin: EdgeInsets.only(top: 2, bottom: 2)),
    Tab(
        icon: Icon(Icons.category),
        text: "Categories",
        iconMargin: EdgeInsets.only(top: 2, bottom: 2)),
    Tab(
        icon: Icon(Icons.person),
        text: "Creators",
        iconMargin: EdgeInsets.only(top: 2, bottom: 2))
  ];

  static const List<Widget> tabViews = <Widget>[
    ItemsTabView(),
    CategoriesTabView(),
    CreatorsTabView()
  ];

  int lastSelectedTabIndex = 0;
  void _setLastSelectedTabIndex() {
    lastSelectedTabIndex = _tabController.index;
  }

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this, initialIndex: lastSelectedTabIndex);
    _tabController.addListener(_setLastSelectedTabIndex);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.index = lastSelectedTabIndex;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: TabBar(
                controller: _tabController,
                tabs: tabs,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabViews,
      ),
    );
  }
}
