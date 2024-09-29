import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.onLogoutTap();
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}