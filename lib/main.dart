import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:laundry/core/services/app_lock_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
    await GetStorage.init();

  Get.put<AppLockService>(AppLockService(), permanent: true);
  // Initialize services here
  // await initServices();
  
  runApp(const MyApp());
}
