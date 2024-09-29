import 'package:get/get.dart';

import 'package:beerenyi/app/routes/pages.dart';
import 'package:beerenyi/app/services/pocketbase.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;

  void onLogoutTap() {
    try {
      PocketbaseService.to.logout();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.log(e.toString());
    }
  }
}