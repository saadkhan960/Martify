import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:martify/myapp.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //Initialized Local Storage
  await GetStorage.init();

  //Await Native Splash Screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialized Firebase & Authntication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
