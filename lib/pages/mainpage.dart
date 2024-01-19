import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:login_firebase_testtask/controllers/auth_controller.dart';
import 'package:login_firebase_testtask/controllers/nameprefs_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...Get.find<NamePrefsCont>().getName()!.map((e) => Text(e)),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: leave,
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> leave() async {
    await Get.find<FirebaseController>().signOutUser();
  }
}
