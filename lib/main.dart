import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:beerenyi/app/services/storage.dart';
import 'package:beerenyi/app/services/pocketbase.dart';

import 'app/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => PocketbaseService().init());

  runApp(
    GetMaterialApp(
      title: "DÖK app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.greenAccent
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.green
      ),
      // TODO: Implement themeMode switching
      themeMode: ThemeMode.dark,
      initialRoute: PocketbaseService.to.isAuth ? Routes.DASHBOARD : Routes.LOGIN,
      getPages: AppPages.routes,  
    )
  );
}
