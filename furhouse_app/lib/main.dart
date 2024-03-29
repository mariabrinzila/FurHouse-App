import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'main_display.dart';

import 'configuration/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MainDisplay());
}
