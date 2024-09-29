import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/turtles/books.png"), width: 150),
              const SizedBox(height: 16),
              const Text(
                'Szia,',
                style: TextStyle(fontSize: 24),
              ),
              const Text(
                'üdvözlünk a DÖK appban!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final error = await Get.find<LoginController>().onLogin();
                  if (error == null) {
                    Get.find<LoginController>().onLoginComplete();
                  } else {
                    Get.snackbar("Error", error);
                  }
                },
                child: const Text('Bejelentkezés'),
              ),
            ],
          ),
        )
    ),
    );
  }
}
