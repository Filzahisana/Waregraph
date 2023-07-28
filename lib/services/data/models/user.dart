import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waregraph/services/data/models/doc.dart';

class UserModel {
  final String docId;
  final String name;
  final String email;
  final int role;
  final bool isActive;
  final List? log;

  UserModel(
      {required this.docId,
      required this.name,
      required this.email,
      required this.role,
      required this.isActive,
      this.log});

  UserModel.fromDocumentSnapshot(DocumentSnapshot docSnap)
      : docId = docSnap.id,
        name = docSnap.get('name'),
        email = docSnap.get('email'),
        role = docSnap.get('role'),
        isActive = docSnap.get('isActive'),
        log = docSnap.get('log') ?? {};
}

extension ToDocsSnapData on UserModel {
  DocSnapData toDocSnapData() {
    return DocSnapData(docId: docId, data: {
      'name': name,
      'email': email,
      'role': role,
      'isActive': isActive,
      'log': log ?? {}
    });
  }
}
