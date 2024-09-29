import 'package:get/get.dart';

import 'package:beerenyi/app/bindings/dashboard.dart';
import 'package:beerenyi/app/modules/dashboard/view.dart';

import 'package:beerenyi/app/bindings/login.dart';
import 'package:beerenyi/app/modules/login/view.dart';

part 'routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
  ];
}
