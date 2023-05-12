import 'package:flutter/material.dart';
import 'package:siksik_labuyo/view/pages/dashboard/dashboard_page.dart';
import 'package:siksik_labuyo/view/pages/inventory/inventory_page.dart';
import 'package:siksik_labuyo/view/pages/pos/pos_items_page.dart';
import 'package:siksik_labuyo/view/pages/pos/pos_cart_page.dart';
import 'package:siksik_labuyo/view/pages/reports/report_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

/*
  Bianca De Los Angeles, Aaron Serrano
  Team: IDK
  Project: Siksik Labuyo
  Feature: [LBYO - 001] Bottom Navigation Bar
  Feature Description:
    The UI for the app's bottom navbar. For navigation purposes to other pages.
 */

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
        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      });
    }

    // A bottom navigation bar
    List<BottomNavigationBarItem> bottomNavBarItems = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: "Items",
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
