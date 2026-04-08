import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/bindings/initial_binding.dart';
import 'package:laundry/core/services/app_lock_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final initialRoute = AppLockService.to.shouldShowLockOnLaunch()
        ? AppRoutes.LOCK
        : AppRoutes.SPLASH;
    return ScreenUtilInit(
      designSize: Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Color(0xffffffff),
              scrolledUnderElevation: 0,
            ),
            scaffoldBackgroundColor: Color(0xffffffff),
          ),
          initialRoute: initialRoute,
          getPages: pages,
          initialBinding: InitialBinding(),
        );
      },
    );
  }
}
