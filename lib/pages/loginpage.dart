import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:login_firebase_testtask/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Регистрация'),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: firstnameController,
            ),
            TextField(
              controller: secondNameController,
            ),
            TextField(
              controller: lastNameController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: login, child: const Text('Войти'))
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    Map<String, String?> names = {
      'firstname': firstnameController.text,
      'secondname': secondNameController.text,
      'lastname': lastNameController.text,
    };
    Get.find<FirebaseController>().signInUserAnonymously(names);
  }
}
