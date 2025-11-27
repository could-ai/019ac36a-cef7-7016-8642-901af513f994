import 'package:flutter/material.dart';
import 'package:supermarket_app/widgets/sidebar.dart';
import 'package:supermarket_app/screens/billing_screen.dart';
import 'package:supermarket_app/screens/products_screen.dart';
import 'package:supermarket_app/screens/customers_screen.dart';
import 'package:supermarket_app/screens/settings_screen.dart';
import 'package:supermarket_app/screens/dashboard_home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardHomeScreen(),
    BillingScreen(),
    ProductsScreen(),
    CustomersScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Sidebar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }
}
