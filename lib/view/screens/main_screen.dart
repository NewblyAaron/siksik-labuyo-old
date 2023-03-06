import 'package:flutter/material.dart';
import 'package:siksik_labuyo/view/pages/dashboard_page.dart';
import 'package:siksik_labuyo/view/pages/inventory/inventory_page.dart';
import 'package:siksik_labuyo/view/pages/items_page.dart';
import 'package:siksik_labuyo/view/pages/point_of_sale_page.dart';
import 'package:siksik_labuyo/view/pages/report_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int bottomNavbarSelectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(
      initialPage: 2,
      keepPage: true,
    );

    void pageChanged(int index) {
      setState(() {
        bottomNavbarSelectedIndex = index;
      });
    }

    Widget buildPageView() {
      return PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ItemPage(),
          PointOfSalePage(),
          DashboardPage(),
          InventoryPage(),
          ReportPage(),
        ],
        onPageChanged: (index) {
          pageChanged(index);
        },
      );
    }

    void bottomNavbarTapped(int index) {
      setState(() {
        bottomNavbarSelectedIndex = index;
        pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease);
      });
    }

    // A bottom navigation bar
    List<BottomNavigationBarItem> bottomNavBarItems = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: "Items",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: "Point-of-Sale",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Dashboard",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.inventory),
        label: "Inventory",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.analytics),
        label: "Report",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Siksik Labuyo"),
      ),
      body: buildPageView(),

      // Bottom NAVBAR
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavBarItems,
        currentIndex: bottomNavbarSelectedIndex,
        onTap: (index) {
          bottomNavbarTapped(index);
        },
      ),
    );
  }
}
