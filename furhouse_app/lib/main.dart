import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'configuration/firebase_options.dart';
import 'main_display.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainDisplay());
}
