import 'package:flutter/material.dart';
import 'package:furhouse_app/common/widget_templates/outlined_button_style.dart';

import 'package:furhouse_app/screens/home/home_content.dart';

import 'package:furhouse_app/common/constants/colors.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _homeKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    setState(() {
      _homeKey.currentState?.openDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _homeKey,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: darkBlueColor,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
            ),
            onPressed: () {
              _openDrawer();
            },
          ),
          title: Image.asset(
            'assets/images/Logo.png',
            color: Colors.white,
            width: 250,
            height: 180,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: 'Account settings',
              icon: const Icon(
                Icons.settings,
              ),
              onPressed: () {},
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: lighterBlueColor,
          child: ListView(
            children: [
              OutlinedButtonStyle(
                buttonText: 'Pets',
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                lighterBlueColor,
                lightBlueColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const HomeContent(),
        ),
      ),
    );
  }
}
