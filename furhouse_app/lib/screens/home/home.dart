import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:furhouse_app/screens/home/home_content.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/widget_templates/tab_style.dart';

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
  /*final GlobalKey<ScaffoldState> _homeKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    setState(() {
      _homeKey.currentState?.openDrawer();
    });
  }*/

  TabBar get _tabBarStyle {
    return const TabBar(
      indicatorColor: Colors.white,
      unselectedLabelColor: unselectedLabelColor,
      tabs: [
        TabStyle(
          iconData: Icons.pets_rounded,
          tabLabel: 'Adopt',
        ),
        TabStyle(
          iconData: CupertinoIcons.add_circled_solid,
          tabLabel: 'Add pet',
        ),
        TabStyle(
          iconData: CupertinoIcons.search_circle_fill,
          tabLabel: 'Search',
        ),
        TabStyle(
          iconData: Icons.settings,
          tabLabel: 'Settings',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          /*key: _homeKey,*/
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: darkBlueColor,
            title: Image.asset(
              'assets/images/Logo.png',
              color: Colors.white,
              width: 250,
              height: 180,
            ),
            centerTitle: true,
          ),
          /*drawer: Drawer(
            backgroundColor: lighterBlueColor,
            width: 200,
            child: ListView(
              children: const [
                TextButtonStyle(
                  buttonText: 'Breeds',
                ),
                TextButtonStyle(
                  buttonText: 'Lost pets',
                ),
                TextButtonStyle(
                  buttonText: 'Find the pet for you',
                ),
              ],
            ),
          ),*/
          bottomNavigationBar: PreferredSize(
            preferredSize: _tabBarStyle.preferredSize,
            child: Material(
              color: darkerBlueColor,
              child: _tabBarStyle,
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  lightBlueColor,
                  lighterBlueColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const TabBarView(
              children: [
                HomeContent(),
                HomeContent(),
                HomeContent(),
                HomeContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
