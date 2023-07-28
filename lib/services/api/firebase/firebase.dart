import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunct {
  static final FirebaseFirestore _firestoreInstance =
      FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<QuerySnapshot> getSnapshot({required String collection}) async {
    return await _firestoreInstance.collection(collection).get();
  }

  Future<DocumentSnapshot> getDoc(
      {required String collection, required String doc}) async {
    return await _firestoreInstance.collection(collection).doc(doc).get();
  }

  Future<bool> updateDocGlobalCollection(
      {required String collection,
      required String docId,
      required Map<String, dynamic> field}) async {
    try {
      await _firestoreInstance.collection(collection).doc(docId).update(field);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteDocGlobalCollection(
      {required String collection, required String docId}) async {
    try {
      await _firestoreInstance.collection(collection).doc(docId).delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
