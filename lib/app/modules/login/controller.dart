import 'package:get/get.dart';
import 'package:beerenyi/app/services/pocketbase.dart';

import '../../routes/pages.dart';

class LoginController extends GetxController {
  Future<String?> onLogin() async {
    try {
      await PocketbaseService.to.login();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  void onLoginComplete() {
    Get.offAllNamed(Routes.DASHBOARD);
  }
}