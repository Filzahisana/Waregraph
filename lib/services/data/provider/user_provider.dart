import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:waregraph/services/auth/auth.dart';
import 'package:waregraph/services/auth/wrapper.dart';
import 'package:waregraph/services/data/models/user.dart';
import 'package:waregraph/view/layout/layout.dart';
import 'package:waregraph/view/pages/login/login.dart';

class UserProvider with ChangeNotifier {
  UserModel? userData;
  bool? isExists;
  Widget screenBody = const Splash();

  void anonymouslyLogin() async {
    await AuthServices.anonymouslyLogin();
  }

  void onInit() {
    print('reset user provider to default value');
    userData = null;
    isExists = null;
    screenBody = const Splash();
  }

  Future<bool> getUserData() async {
    onInit();
    bool result = await AuthServices.userIsExists(this);
    isExists = result;
    return result;
  }

  void logout() async {
    await AuthServices.logout();
  }

  void processUser() async {
    print('processing user through provider ..');
    bool value = await getUserData();
    print('user data is catched');
    if (value == true) {
      if (userData!.isActive) {
        print(
            'user is active : ${userData!.isActive.toString()}, go to Dashboard');
        screenBody = const MainWaregraphLayout();
      } else {
        print('user is non active, exiting');
        logout();
        onInit();
      }
    } else {
      print("user doesn't exists, exiting ..");
      logout();
      onInit();
    }
  }
}
