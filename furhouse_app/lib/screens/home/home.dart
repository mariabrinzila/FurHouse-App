import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:furhouse_app/screens/home/home_tab.dart';
import 'package:furhouse_app/screens/home/add_pet_tab.dart';
import 'package:furhouse_app/screens/home/settings_tab.dart';

import 'package:furhouse_app/common/constants/picker_values.dart';
import 'package:furhouse_app/common/widget_templates/tab_style.dart';
import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/services/web_scraper.dart';

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
  TabBar get _tabBarStyle {
    return const TabBar(
      indicatorColor: Colors.white,
      unselectedLabelColor: unselectedLabelColor,
      tabs: [
        TabStyle(
          iconData: CupertinoIcons.home,
        ),
        TabStyle(
          iconData: CupertinoIcons.add_circled_solid,
        ),
        TabStyle(
          iconData: CupertinoIcons.search_circle_fill,
        ),
        TabStyle(
          iconData: CupertinoIcons.settings,
        ),
      ],
    );
  }

  @override
  void initState() {
    var scraper = WebScraper();
    catBreedValues = [];
    dogBreedValues = [];
    rabbitBreedValues = [];
    rodentBreedValues = [];
    birdBreedValues = [];
    allBreedValues = [];

    scraper.scrapCatBreeds();
    scraper.scrapDogBreeds();
    scraper.scrapRabbitBreeds();
    scraper.scrapRodentBreeds();
    scraper.scrapBirdBreeds();

    allBreedValues.sort();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: darkBlueColor,
            centerTitle: true,
            title: Image.asset(
              'assets/images/Logo.png',
              color: Colors.white,
              width: 250,
              height: 180,
            ),
          ),
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
            child: TabBarView(
              children: [
                const HomeTab(),
                AddPetTab(),
                const HomeTab(),
                const SettingsTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
