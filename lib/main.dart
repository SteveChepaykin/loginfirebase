import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:login_firebase_testtask/controllers/auth_controller.dart';
import 'package:login_firebase_testtask/controllers/nameprefs_controller.dart';
import 'package:login_firebase_testtask/firebase_options.dart';
import 'package:login_firebase_testtask/models/usermodel.dart';
import 'package:login_firebase_testtask/pages/loginpage.dart';
import 'package:login_firebase_testtask/pages/mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var namecont = NamePrefsCont();
  await namecont.init();
  var fcont = FirebaseController();
  fcont.listenUserAuthState();
  Get.put<FirebaseController>(fcont);
  Get.put<NamePrefsCont>(namecont);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<UserModel?>(
          stream: Get.find<FirebaseController>().currentUser$.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoginPage();
            }
            return const MainPage();
          },
        ),
    );
  }
}

