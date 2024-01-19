import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NamePrefsCont extends GetxController {
  late List<String> name;
  static const namekey = 'namesKey';

  late final SharedPreferences prefs;

  // SettingsController() {
  //   prefs = SharedPreferences.getInstance();
  // }
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    name = getName()!;
  }

  Future<void> setName(List<String> names) {
    return prefs.setStringList(namekey, names);
  }

  List<String>? getName() {
    return prefs.containsKey(namekey) ? prefs.getStringList(namekey) : [];
  }
}
