import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:login_firebase_testtask/controllers/nameprefs_controller.dart';
import 'package:login_firebase_testtask/models/usermodel.dart';

class FirebaseController extends GetxController {
  late final FirebaseFirestore _store;

  UserModel? currentUser;
  late Rx<UserModel?> currentUser$;

  FirebaseController() {
    _store = FirebaseFirestore.instance;
    currentUser$ = currentUser.obs;
  }

  void setCurrentUser(UserModel? user) {
    currentUser = user;
    currentUser$.value = user;
  }

  void listenUserAuthState() {
    FirebaseAuth.instance.authStateChanges().listen(onUserAuthStateChange);
  }

  Future<void> onUserAuthStateChange(User? user) async {
    if (user != null && user.isAnonymous) {
      var u = await getUserByName(Get.find<NamePrefsCont>().name);
      setCurrentUser(u);
    } else {
      setCurrentUser(null);
    }
  }

  Future<UserModel> getUserByName(List<String> name) async {
    var a = await _store.collection('people').where('firstname', isEqualTo: name[0]).where('secondname', isEqualTo: name[1]).where('lastname', isEqualTo: name[2]).limit(1).get();
    return UserModel.fromMap(a.docs[0].id, a.docs[0].data());
  }

  Future<String?> signInUserAnonymously(Map<String, String?> m) async {
    var a = await _store.collection('people').where('email', isEqualTo: m['email']).get();
    if (a.docs.isNotEmpty) {
      var u = await getUserByName(Get.find<NamePrefsCont>().getName()!);
      setCurrentUser(u);
      return 'This user already exists in app';
    } else {
      await adduser({
        'firstname': m['firstname'],
        'secondname': m['secondname'],
        'lastname': m['lastname'],
      });
      Get.find<NamePrefsCont>().setName([m['firstname']!, m['secondname']!, m['lastname']!]);
      try {
        await FirebaseAuth.instance.signInAnonymously();
      } on FirebaseAuthException catch (_) {
        return 'loginerror';
      }
      var u = await getUserByName(Get.find<NamePrefsCont>().getName()!);
      setCurrentUser(u);
    }
    return null;
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
    await Get.find<NamePrefsCont>().setName(<String>[]);
    setCurrentUser(null);
  }

  Future<void> adduser(Map<String, dynamic> m) async {
    var q = await _store.collection('people').add({
      'firstname': m['firstname']!,
      'secondname': m['secondname']!,
      'lastname': m['lastname']!,
    });
    var z = await q.get();
    var u = UserModel.fromMap(z.id, z.data()!);
    setCurrentUser(u);
  }
}
