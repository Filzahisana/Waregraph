import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waregraph/services/data/models/doc.dart';

class Barang {
  final String? docId;
  final String code;
  final String category;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? redCodeMargin;
  final int? yellowCodeMargin;
  final int? greenCodeMargin;

  Barang(
      {this.docId,
      required this.code,
      required this.category,
      required this.name,
      required this.createdAt,
      required this.updatedAt,
      this.redCodeMargin,
      this.yellowCodeMargin,
      this.greenCodeMargin});

  Barang.fromDocSnap(DocumentSnapshot doc)
      : docId = doc.id,
        code = doc.get('code'),
        category = doc.get('category'),
        name = doc.get('name'),
        redCodeMargin = doc.get('redCodeMargin'),
        yellowCodeMargin = doc.get('yellowCodeMargin'),
        greenCodeMargin = doc.get('greenCodeMargin'),
        createdAt = (doc.get('createdAt') as Timestamp).toDate(),
        updatedAt = (doc.get('createdAt') as Timestamp).toDate();
}

extension ToDocsSnapData on Barang {
  DocSnapData toDocSnapData() {
    return DocSnapData(docId: docId, data: {
      'code': code,
      'category': category,
      'name': name,
      'redCodeMargin': redCodeMargin,
      'yellowCodeMargin': yellowCodeMargin,
      'greenCodeMargin': greenCodeMargin,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    });
  }
}
