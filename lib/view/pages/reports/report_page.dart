import 'package:flutter/material.dart';
import 'package:siksik_labuyo/view/pages/reports/report_tabs/general_report.dart';
import 'package:siksik_labuyo/view/pages/reports/report_tabs/creators_report.dart';

/* Alejandro Miguel A. Monge
Team: Siksik Labuyo
Project Name: Siksik Labuyo
Feature: [LBYO - 400] <RPT> Report
Feature description: 
  This should be the page to display such as sales report which can be for 
  general or specific creators.                    
 */
class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with TickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> tabs = <Tab>[
    Tab(
      text: "General",
    ),
    Tab(
      text: "Creators",
    ),
  ];

  static const List<Widget> tabViews = <Widget>[
    GeneralReport(),
    CreatorsReport(),
  ];

  int lastSelectedTabIndex = 0;
  void _setLastSelectedTabIndex() {
    lastSelectedTabIndex = _tabController.index;
  }

  @override
  void initState() {
    _tabController = TabController(
        length: tabs.length, vsync: this, initialIndex: lastSelectedTabIndex);
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
