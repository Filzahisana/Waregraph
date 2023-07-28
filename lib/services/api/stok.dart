import 'package:waregraph/services/api/barang.dart';
import 'package:waregraph/services/api/firebase/firebase.dart';
import 'package:waregraph/services/data/models/barang.dart';
import 'package:waregraph/services/data/models/doc.dart';
import 'package:waregraph/services/data/models/stok.dart';

class StokApi {
  static final funct = FirebaseFunct();

  static Future<List<Stok>> getPipaBesar() async {
    List<Stok> dataStok = await funct.getSnapshot(collection: 'stok').then(
        (value) =>
            value.docs.map((e) => Stok.fromDocumentSnapshot(e)).toList());

    List<Barang> pipaBesar = await BarangApi.getBarangs().then((value) => value
        .where(
            (element) => element.category.toLowerCase().contains('pipa besar'))
        .toList());

    List<Stok> result = [];

    for (var e in pipaBesar) {
      result
          .add(dataStok.where((element) => element.barangCode == e.code).first);
    }
    return result;
  }

  static Future<List<Stok>> getPipaKecil() async {
    List<Stok> dataStok = await funct.getSnapshot(collection: 'stok').then(
        (value) =>
            value.docs.map((e) => Stok.fromDocumentSnapshot(e)).toList());

    List<Barang> pipaKecil = await BarangApi.getBarangs().then((value) => value
        .where(
            (element) => element.category.toLowerCase().contains('pipa kecil'))
        .toList());

    List<Stok> result = [];

    for (var e in pipaKecil) {
      result
          .add(dataStok.where((element) => element.barangCode == e.code).first);
    }
    return result;
  }

  static Future<List<Stok>> getMeterStok() async {
    List<Stok> dataStok = await funct.getSnapshot(collection: 'stok').then(
        (value) =>
            value.docs.map((e) => Stok.fromDocumentSnapshot(e)).toList());

    List<Barang> meter = await BarangApi.getBarangs().then((value) => value
        .where((element) => element.category.toLowerCase().contains('meter'))
        .toList());

    List<Stok> result = [];

    for (var e in meter) {
      result
          .add(dataStok.where((element) => element.barangCode == e.code).first);
    }
    return result;
  }

  static Future<int> updateStok(Stok data) async {
    try {
      DocSnapData updateData = data.toDocSnapData();
      await funct.updateDocGlobalCollection(
          collection: 'stok', docId: updateData.docId, field: updateData.data);
      return 200;
    } catch (e) {
      print(e);
      return 400;
    }
  }

  static Future<int> deleteStok(List<String> docIdList) async {
    try {
      for (var element in docIdList) {
        await funct.deleteDocGlobalCollection(
            collection: 'stok', docId: element);
      }
      return 200;
    } catch (e) {
      print(e);
      return 400;
    }
  }
}
