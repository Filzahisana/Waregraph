import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waregraph/services/data/models/doc.dart';

class Stok {
  final String docId;
  final String barangCode;
  final String month;
  final int total;
  final DateTime createdAt;
  final DateTime updatedAt;

  Stok(
      {required this.docId,
      required this.barangCode,
      required this.month,
      required this.total,
      required this.createdAt,
      required this.updatedAt});

  Stok.fromDocumentSnapshot(DocumentSnapshot docSnap)
      : docId = docSnap.id,
        barangCode = docSnap.get('barangCode'),
        month = docSnap.get('month'),
        total = int.parse(docSnap.get('total').toString()),
        createdAt = (docSnap.get('createdAt') as Timestamp).toDate(),
        updatedAt = (docSnap.get('createdAt') as Timestamp).toDate();
}

extension ToDocsSnapData on Stok {
  DocSnapData toDocSnapData() {
    return DocSnapData(docId: docId, data: {
      'code': barangCode,
      'month': month,
      'total': total,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    });
  }
}
