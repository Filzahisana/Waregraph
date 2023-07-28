import 'package:waregraph/services/api/firebase/firebase.dart';
import 'package:waregraph/services/data/models/barang.dart';
import 'package:waregraph/services/data/models/doc.dart';

class BarangApi {
  static final funct = FirebaseFunct();

  static Future<int> saveBarangs(List<Barang> barangs) async {
    try {
      List<DocSnapData> data = barangs.map((e) => e.toDocSnapData()).toList();
      for (var element in data) {
        await funct.firestore
            .collection('barang')
            .doc(element.docId)
            .set(element.data);
      }
      return 200;
    } catch (e) {
      print(e);
      return 400;
    }
  }

  static Future<List<Barang>> getBarangs() async {
    List<Barang> data = await funct
        .getSnapshot(collection: 'barang')
        .then((value) => value.docs.map((e) => Barang.fromDocSnap(e)).toList());

    return data;
  }

  static Future<int> updateBarang(Barang barang) async {
    try {
      DocSnapData data = barang.toDocSnapData();
      await funct.updateDocGlobalCollection(
          collection: 'barang', docId: data.docId!, field: data.data);
      return 200;
    } catch (e) {
      print(e);
      return 400;
    }
  }

  static Future<int> deleteBarang(String docId) async {
    try {
      await funct.deleteDocGlobalCollection(collection: 'barang', docId: docId);
      return 200;
    } catch (e) {
      print(e);
      return 400;
    }
  }
}
