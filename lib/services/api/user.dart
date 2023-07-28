import 'package:firebase_auth/firebase_auth.dart';
import 'package:waregraph/services/api/firebase/firebase.dart';
import 'package:waregraph/services/data/models/doc.dart';
import 'package:waregraph/services/data/models/user.dart';

class UserApi {
  static final funct = FirebaseFunct();
  static Future<UserModel?> getOnceUser() async {
    UserModel? userData = await funct
        .getDoc(collection: 'user', doc: funct.authInstance.currentUser!.uid)
        .then((value) =>
            value.exists ? UserModel.fromDocumentSnapshot(value) : null);

    return userData;
  }

  static Future<List<UserModel>> getUsers() async {
    List<UserModel> data = await funct.getSnapshot(collection: 'user').then(
        (value) =>
            value.docs.map((e) => UserModel.fromDocumentSnapshot(e)).toList());
    return data;
  }

  static Future<int> updateOnce(UserModel user) async {
    try {
      DocSnapData data = user.toDocSnapData();
      await funct.updateDocGlobalCollection(
          collection: 'user', docId: data.docId!, field: data.data);
      return 200;
    } catch (e) {
      print(e);
      return 400;
    }
  }

  static Future<int> disableUsers(List<String> docIdList) async {
    try {
      for (var element in docIdList) {
        await funct.updateDocGlobalCollection(
            collection: 'user', docId: element, field: {'isActive': false});
      }
      return 200;
    } catch (e) {
      return 400;
    }
  }

  static Future<int> activateUsers(List<String> docIdList) async {
    try {
      for (var element in docIdList) {
        await funct.updateDocGlobalCollection(
            collection: 'user', docId: element, field: {'isActive': true});
      }
      return 200;
    } catch (e) {
      return 400;
    }
  }

  static Future<int> deleteUsers(List<String> docIdList) async {
    try {
      for (var element in docIdList) {
        await funct.deleteDocGlobalCollection(
            collection: 'user', docId: element);
      }
      return 200;
    } catch (e) {
      return 400;
    }
  }
}
