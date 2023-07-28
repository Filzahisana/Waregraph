import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

class ExcelHelper {
  static Future<List<Map<String, dynamic>>> xlsxToList(
      Uint8List fileBytes) async {
    List<Map<String, dynamic>> result = [];
    List<String> keyList = [];

    ByteData byteData = ByteData.view(fileBytes.buffer);
    var data = byteData.buffer.asUint8List();

    var excel = Excel.decodeBytes(data);
    final table = excel.tables[excel.tables.keys.first];

    // detect first row as keys
    for (int i = 0; i < table!.rows.first.length; i++) {
      keyList.add(table.rows.first[i]!.value
          .toString()
          .replaceAll(' ', '')
          .toLowerCase());
    }

    // add table values
    for (int i = 1; i < table.rows.length; i++) {
      Map<String, dynamic> rowMap = {};
      for (int j = 0; j < keyList.length; j++) {
        rowMap.addAll({'${keyList[j]}': table.rows[i][j]!.value.toString()});
      }
      result.add(rowMap);
    }
    return result;
    // for (var row in table.rows) {
    //   for (var cell in row) {
    //     try {
    //       if (cell!.value.runtimeType == DateTime) {
    //         DateTime dateTimeValue = cell.value;
    //         if (dateTimeValue.isBefore(DateTime(1)) ||
    //             dateTimeValue.isAfter(DateTime(9999))) {
    //           // Handle invalid DateTime value
    //           print("Invalid DateTime value: $dateTimeValue");
    //         } else {
    //           // Valid DateTime value within the range
    //           print(dateTimeValue.runtimeType);
    //         }
    //       } else {
    //         // Handle other cell values
    //         print(cell.value.runtimeType);
    //       }
    //     } catch (e) {
    //       print("Error accessing runtimeType: $e");
    //     }
    //   }
    // }
  }
}
