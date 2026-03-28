import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Initialize services here
  // await initServices();
  
  runApp(const MyApp());
}
