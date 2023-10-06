import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'main_display.dart';

import 'configuration/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /*var scraper = WebScraper();
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
  scraper.scrapBirdBreeds();*/

  runApp(MainDisplay());
}
