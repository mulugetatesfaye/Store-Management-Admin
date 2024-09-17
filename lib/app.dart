import 'package:ahmedadmin/screens/damaged_product_page.dart';
import 'package:ahmedadmin/screens/deliveries_page.dart';
import 'package:ahmedadmin/screens/expense_page.dart';
import 'package:ahmedadmin/screens/purchased_page.dart';
import 'package:ahmedadmin/screens/report_page.dart';
import 'package:ahmedadmin/screens/sell_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;
    final pages = [
      const ReportPageResponsive(),
      const PurchasedPage(),
      const SellPage(),
      ExpenseListPage(),
      const DeliveriesListPage(),
      const DamagedProductsPage(),
    ];
    return DefaultTabController(
      length: pages.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'አህመድ ትሬዲንግ',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 2,
          bottom: !isDesktop
              ? const TabBar(
                  unselectedLabelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.blue,
                  indicatorWeight: 4,
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  tabs: [
                    Tab(icon: Icon(Icons.home)),
                    Tab(text: 'ግዢ'),
                    Tab(text: 'ሽያጭ'),
                    Tab(text: 'ወጪ'),
                    Tab(text: 'የጫኑ መኪናዎች'),
                    Tab(text: 'የተበላሹ እቃዎች'),
                  ],
                )
              : null,
        ),
        body: TabBarView(
          children: pages,
        ),
      ),
    );
  }
}
