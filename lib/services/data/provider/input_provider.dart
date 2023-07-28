import 'dart:typed_data';
import 'dart:html' as html;

import 'package:floating_overlay/floating_overlay.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:waregraph/services/data/helper/excel.dart';
import 'package:waregraph/view/pages/input/input.dart';

class InputDataProvider with ChangeNotifier {
  // double width = WidgetsBinding.instance.renderView.size.width;
  Size? size;
  bool onAsync = false;
  Uint8List? excelFile;
  int selectedPage = 1;
  bool isGlobalMargin = false;
  String notificationTitle = 'Notification';
  Widget notificationBody = const Text(
    'one new notification',
    style: TextStyle(color: Colors.white),
  );
  String notificationDetail = 'nice';
  late Rect rect;

  FloatingOverlayController overlayControl =
      FloatingOverlayController.absoluteSize(
    maxSize: const Size(250, 75),
    minSize: const Size(250, 75),
    start: Offset(0, 70),
    padding: const EdgeInsets.all(20.0),
    constrained: true,
  );

  List<Map<String, dynamic>> page = [
    {
      'menuName': 'Tambah Data Barang',
      'title': 'Tambah Barang Baru',
      'inputWidget': const TambahBarangField()
    },
    {
      'menuName': 'Tambah Data Stok',
      'title': 'Tambah Data Ketersediaan Barang',
      'inputWidget': const TambahDataStokField()
    },
    {
      'menuName': 'Tambah Kategori',
      'title': 'Tambah Kategori Barang',
      'inputWidget': const TambahDataStokField()
    },
    {
      'menuName': 'Setelan Margin',
      'title': 'Setelan Margin Stok Global',
      'inputWidget': const TambahDataStokField()
    },
  ];

  void setOverlayController() {
    overlayControl = FloatingOverlayController.absoluteSize(
      maxSize: const Size(250, 75),
      minSize: const Size(250, 75),
      start: Offset.zero,
      padding: const EdgeInsets.all(20.0),
      constrained: true,
    );
  }

  void showNotificationProgress(double percent, String detail) {
    print(WidgetsBinding.instance.renderView.size.width);
    Widget barProgress = LinearPercentIndicator(
      width: 150.0,
      lineHeight: 8.0,
      percent: percent,
      progressColor: Colors.white,
    );

    notificationTitle = 'Tambah Data Barang';
    notificationBody = barProgress;
    notificationDetail = detail;
    // if (overlayControl == null) {
    //   print('overlayControl is null, initiating overlay widget');
    //   setOverlayController();
    // }
    print(
        'notification is closed : ' + (!overlayControl.isFloating).toString());
    if (!overlayControl.isFloating) {
      print('showing floating notification');
      overlayControl.show();
    }
    print("is notification on : " + overlayControl.isFloating.toString());
  }

  void closeNotification() {
    overlayControl.close();
  }

  void isGlobalMarginSet(bool val) {
    isGlobalMargin = val;
    notifyListeners();
  }

  void setPage(int index) {
    selectedPage = index;
    isGlobalMargin = false;
    notifyListeners();
  }

  void setExcelToNull() {
    excelFile = null;
  }

  void proccessDataBarang() async {
    if (excelFile != null && selectedPage == 0) {}
  }

  void processFile() async {
    if (excelFile != null && selectedPage == 1) {
      List<Map<String, dynamic>> data =
          await ExcelHelper.xlsxToList(excelFile!);
      print(data.toString());
      print('');
      print('');
      print('');
      for (var element in data) {
        print(element.toString());
      }
    }
  }

  void processBarangFile() async {
    // if (excelFile != null && selectedPage == 0) {
    showNotificationProgress(0, 'memproses file');
    Future.delayed(Duration(milliseconds: 3000), () {
      showNotificationProgress(0.2, 'memulai unggah');
    });

    Future.delayed(Duration(milliseconds: 2000), () {
      showNotificationProgress(0.3, 'mengunggah data');
    });

    showNotificationProgress(1, 'sukses mengunggah');
    // List<Map<String, dynamic>> data =
    //     await ExcelHelper.xlsxToList(excelFile!);
    // List<Barang> barangs = [];
    // print('');
    // print('');
    // for (var element in data) {
    //   print(element.toString());
    // }

    // print('begin processing data');
    // for (var i = 0; i < data.length; i++) {
    //   barangs.add(Barang(
    //       docId: data[i]['kode'],
    //       code: data[i]['kode'],
    //       category: data[i]['kategori'],
    //       name: data[i]['nama'],
    //       createdAt: DateTime.timestamp(),
    //       updatedAt: DateTime.timestamp(),
    //       redCodeMargin: int.parse(data[i]['redcode']),
    //       yellowCodeMargin: int.parse(data[i]['yellowcode']),
    //       greenCodeMargin: int.parse(data[i]['greencode'])));
    // }
    // print('Begin uploading data barang');
    // int result = await BarangApi.saveBarangs(barangs);
    // if (result == 200) {
    //   setExcelToNull();
    //   print('success uploading barangs');
    // }
    // }
  }

  void saveCategory() async {
    if (selectedPage == 2) {}
  }

  void saveMarginSettings() async {}

  void onDropFile(dynamic htmlFile) {
    final htmlFileReader = html.FileReader();

    htmlFileReader.onLoadEnd.listen((e) {
      if (htmlFileReader.result is Uint8List) {
        Uint8List data = htmlFileReader.result as Uint8List;
        // Now you have the Uint8List data, you can use it as needed.
        // For example, you can pass it to a function that processes the data.
        excelFile = data;
      }
    });

    htmlFileReader.readAsArrayBuffer(htmlFile);
  }

  void setExcelFile() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final file = uploadInput.files!.first;
      final reader = html.FileReader();

      reader.onLoadEnd.listen((e) {
        if (reader.result is Uint8List) {
          Uint8List data = reader.result as Uint8List;
          // Now you have the Uint8List data, you can use it as needed.
          // For example, you can pass it to a function that processes the data.
          excelFile = data;
        }
      });

      reader.readAsArrayBuffer(file);
    });
  }

  void setSize(BuildContext context) {
    print('setting size');
    size = MediaQuery.of(context).size;
    rect = Rect.fromPoints(Offset.zero, Offset(size!.width, size!.height));
    print(rect.topRight.toString());
  }
}
