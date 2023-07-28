import 'package:floating_overlay/floating_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waregraph/services/data/provider/input_provider.dart';
import 'package:waregraph/view/components/web_data_table.dart';
// import 'package:waregraph/view/layout/components/searchbar.dart';
import 'package:waregraph/view/layout/size.dart';
import 'dart:async';
import 'package:async_searchable_dropdown/async_searchable_dropdown.dart';
import 'package:waregraph/view/pages/input/components/dropzone.dart';

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  DropzoneViewController? dropzoneViewController;
  bool dropOnHover = false;
  // late InputDataProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    // provider = Provider.of<InputDataProvider>(context, listen: false);
    // provider.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InputDataProvider>(
        builder: (context, inputDataProvider, _) {
      if (inputDataProvider.size == null) {
        inputDataProvider.setSize(context);
      }
      // provider = inputDataProvider;
      return FloatingOverlay(
        controller: inputDataProvider.overlayControl,
        // floatingChild: SizedBox.square(
        //   dimension: 100.0,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Theme.of(context).primaryColor,
        //       border: Border.all(
        //         color: Colors.black,
        //         width: 5.0,
        //       ),
        //     ),
        //   ),
        // ),
        floatingChild: Card(
          color: Colors.teal,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          // padding: EdgeInsets.all(2),
          // decoration: BoxDecoration(color: Colors.teal, boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 3,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3), // changes position of shadow
          //   ),
          // ]),
          child: Container(
            width: 250,
            height: 75,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Logo Putih.jpg',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          inputDataProvider.notificationTitle,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        inputDataProvider.notificationBody,
                        Text(
                          inputDataProvider.notificationTitle,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                      ],
                    )
                  ],
                ),
                Positioned(
                    top: 1,
                    right: 1,
                    child: IconButton(
                      iconSize: 12,
                      onPressed: () {
                        inputDataProvider.closeNotification();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: Colors.blueGrey.shade200,
                      ),
                    ))
              ],
            ),
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: Responsive.getWidthFromPrecentage(context, 100),
            padding: EdgeInsets.symmetric(
                vertical: 50,
                horizontal: Responsive.getWidthFromPrecentage(context, 2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        inputDataProvider.page[inputDataProvider.selectedPage]
                            ['title'],
                        style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color: Colors.blueGrey.shade800),
                      ),
                      SizedBox(
                        width: Responsive.getWidthFromPrecentage(
                            context, Responsive.isDesktop(context) ? 40 : 90),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(
                              inputDataProvider.page.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  inputDataProvider.setPage(index);
                                },
                                child: Container(
                                  height: 30,
                                  padding: EdgeInsets.all(2),
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        inputDataProvider.page[index]
                                            ['menuName'],
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade800),
                                      ),
                                      if (inputDataProvider.selectedPage ==
                                          index)
                                        Container(
                                            height: 3,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.purple.shade800))
                                    ],
                                  ),
                                ),
                              ),
                            ).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(18),
                        width: Responsive.getWidthFromPrecentage(context, 25),
                        height: 480,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: inputDataProvider
                                .page[inputDataProvider.selectedPage]
                            ['inputWidget'],
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(left: 46),
                        width: Responsive.getWidthFromPrecentage(context, 60),
                        height: 480,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: inputDataProvider.excelFile != null
                            ? ExcelFileLoaded(
                                callback: () {
                                  setState(() {
                                    dropOnHover = false;
                                  });
                                },
                              )
                            : Stack(
                                children: [
                                  DropZoneFile(
                                      onCreatedDropzoneViewController:
                                          dropzoneViewController,
                                      onDrop: (dynamic htmlFile) {
                                        inputDataProvider.onDropFile(htmlFile);
                                      },
                                      onHover: () {
                                        setState(() {
                                          dropOnHover = true;
                                        });
                                      },
                                      onLeave: () {
                                        setState(() {
                                          dropOnHover = false;
                                        });
                                      },
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: 400,
                                      height: 300,
                                      body: Container(
                                        width: 400,
                                        height: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [],
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 80,
                                            ),
                                            Text(
                                              'or drop your file here',
                                              style: GoogleFonts.poppins(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5,
                                                  color:
                                                      Colors.blueGrey.shade800),
                                            )
                                          ],
                                        ),
                                      )),
                                  if (!dropOnHover)
                                    Positioned(
                                      top: 110,
                                      right: 50,
                                      left: 50,
                                      child: MaterialButton(
                                        onPressed: () {
                                          // inputDataProvider.setExcelFile();
                                          inputDataProvider.processBarangFile();
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        color: const Color.fromARGB(
                                            255, 51, 41, 124),
                                        minWidth: 200,
                                        child: const Text(
                                          'Upload Excel File',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8, top: 50),
                        child: Text(
                          'Data Terbaru',
                          style: GoogleFonts.poppins(
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: Colors.blueGrey.shade800),
                        ),
                      ),
                      // SearchWidget(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: Responsive.getWidthFromPrecentage(context, 90),
                  height: 700,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.pink.withOpacity(0.5),
                      //     spreadRadius: 3,
                      //     blurRadius: 5,
                      //     offset:
                      //         const Offset(0, 3), // changes position of shadow
                      //   ),
                      // ],
                      ),
                  child: InputDatatables(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class TambahBarangField extends StatelessWidget {
  const TambahBarangField({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<InputDataProvider>();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextInput(
            title: 'Nama Barang',
          ),
          TextInput(
            title: 'Kode Barang',
          ),
          DropdownField(
            title: 'Kategori',
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 9, left: 22),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Margin stok',
                    style: TextStyle(
                        color: Color.fromARGB(255, 98, 98, 98), fontSize: 12),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Checkbox(
                          value: prov.isGlobalMargin,
                          onChanged: (val) {
                            prov.isGlobalMarginSet(val!);
                          }),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Gunakan margin global',
                        style: TextStyle(color: Colors.blueGrey.shade800),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInput(
                        title: 'Red code',
                        width: 270,
                        disabled: prov.isGlobalMargin,
                      ),
                      TextInput(
                          title: 'Blue code',
                          width: 270,
                          disabled: prov.isGlobalMargin),
                      TextInput(
                          title: 'Green code',
                          width: 270,
                          disabled: prov.isGlobalMargin)
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: MaterialButton(
              onPressed: () {},
              minWidth: 120,
              height: 45,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: const Color.fromARGB(255, 51, 41, 124),
              colorBrightness: Brightness.dark,
              child: Text('Simpan'),
            ),
          ),
        ],
      ),
    );
  }
}

class TambahDataStokField extends StatelessWidget {
  const TambahDataStokField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // ###########################################################
        // #####################-  Kasih Jarak  -#####################
        // ###########################################################
        DropdownField(title: 'Kategori'),
        DropdownField(title: 'Kode Barang'),
        DropdownField(title: 'Nama Barang'),
        DropdownField(title: 'Bulan'), //Month picker
        DropdownField(title: 'Jumlah'),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: MaterialButton(
            onPressed: () {},
            minWidth: 120,
            height: 45,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: const Color.fromARGB(255, 51, 41, 124),
            colorBrightness: Brightness.dark,
            child: Text('Simpan'),
          ),
        ),
      ],
    );
  }
}

class ExcelFileLoaded extends StatelessWidget {
  const ExcelFileLoaded({super.key, this.callback});
  final Function()? callback;

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<InputDataProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Excel File Loaded',
          style: TextStyle(color: Colors.blueGrey.shade800, fontSize: 14),
        ),
        SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            prov.setExcelToNull();
            if (callback != null) {
              callback!();
            }
          },
          child: Text(
            'Re-upload Excel File',
            style: TextStyle(color: Colors.purple.shade900, fontSize: 11),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        MaterialButton(
          onPressed: () {
            print(prov.selectedPage);
            print(prov.excelFile!.lengthInBytes.toString());
            prov.processFile();
            prov.processBarangFile();
          },
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          minWidth: 75,
          child: Text(
            'Begin Processing File',
          ),
          color: Colors.teal.shade700,
          colorBrightness: Brightness.dark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        )
      ],
    );
  }
}

List<Map<String, dynamic>> data = [
  {
    'no': 1,
    'bulan': 1,
    'category': 'Pipa Besar',
    'kodebarang': '83-PVC',
    'namabarang': 'Pipa PVC SR'
  },
  {
    'no': 2,
    'bulan': 1,
    'category': 'Pipa Kecil',
    'kodebarang': '24-nmsj',
    'namabarang': 'Selang'
  },
  {
    'no': 3,
    'bulan': 3,
    'category': 'Pipa Besar',
    'kodebarang': '1200-DIM-hg',
    'namabarang': 'Pipa PVC Londo'
  },
  {
    'no': 4,
    'bulan': 1,
    'category': 'Pipa Besar',
    'kodebarang': '1000-MNC',
    'namabarang': 'Pipa Sumber Rembulan'
  },
  {
    'no': 5,
    'bulan': 1,
    'category': 'Pipa Longgar',
    'kodebarang': 'unlimited-MNC',
    'namabarang': 'Pipa Sumber Rembulan'
  },
];

Future<List<String>> getData(String? search) async {
  print(search ?? 'kata cari kosong');
  await Future.delayed(const Duration(seconds: 2));
  if (search == null)
    return data.map((e) => e['category'].toString()).toSet().toList();
  List<Map<String, dynamic>> result =
      data.where((e) => e['category'].toString().contains(search)).toList();
  return result.map((e) => e['category'].toString()).toSet().toList();
}

class DropdownField extends StatelessWidget {
  DropdownField({
    super.key,
    required this.title,
  });

  final String title;

  final ValueNotifier<String?> selectedValue = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      // //////////////////////////////////////////////////////////////////////////
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 9),
            //////////////////////////////////////////////////////////////////////
            child: Text(
              title,
              style: TextStyle(
                  color: Color.fromARGB(255, 98, 98, 98), fontSize: 12),
            ),
          ),
          Container(
            width: 300,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 233, 233, 233),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  // spreadRadius: 3,
                  // blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ValueListenableBuilder<String?>(
              valueListenable: selectedValue,
              builder: (context, value, child) {
                return SearchableDropdown<String>(
                  value: value,
                  itemLabelFormatter: (value) {
                    print(value);
                    return value;
                  },
                  remoteItems: getData,
                  onChanged: (value) {
                    selectedValue.value = value;
                    debugPrint('$value');
                  },
                  inputDecoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    // labelText: 'List of items',
                    prefixIcon: Icon(Icons.search),
                  ),
                  borderRadius: BorderRadius.circular(12),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput(
      {super.key,
      required this.title,
      this.onChanged,
      this.width = 300,
      this.disabled = false});
  final String title;
  final Function(String value)? onChanged;
  final double? width;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      // //////////////////////////////////////////////////////////////////////////
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 9),
            //////////////////////////////////////////////////////////////////////
            child: Text(
              title,
              style: TextStyle(
                  color: Color.fromARGB(255, 98, 98, 98), fontSize: 12),
            ),
          ),
          Container(
              width: width,
              height: 40,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 233, 233),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    // spreadRadius: 3,
                    // blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                readOnly: disabled!,
                onChanged: (val) {
                  if (onChanged != null) {
                    onChanged!(val);
                  }
                },
              ))
        ],
      ),
    );
  }
}

class InputDatatables extends StatefulWidget {
  const InputDatatables({super.key});

  @override
  State<InputDatatables> createState() => _InputDatatablesState();
}

class _InputDatatablesState extends State<InputDatatables> {
  late String _sortColumnName;
  late bool _sortAscending;
  List<String>? _filterTexts;
  bool _willSearch = true;
  Timer? _timer;
  int? _latestTick;
  List<String> _selectedRowKeys = [];
  int _rowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _sortColumnName = 'browser';
    _sortAscending = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_willSearch) {
        if (_latestTick != null && timer.tick > _latestTick!) {
          _willSearch = true;
        }
      }
      if (_willSearch) {
        _willSearch = false;
        _latestTick = null;
        setState(() {
          if (_filterTexts != null && _filterTexts!.isNotEmpty) {
            _filterTexts = _filterTexts;
            print('filterTexts = $_filterTexts');
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }

  String getMonth(int currentMonthIndex) {
    return DateFormat('MMMM').format(DateTime(0, currentMonthIndex)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: WebDataTable(
          header: Text('Sample Data'),
          actions: [
            if (_selectedRowKeys.isNotEmpty)
              SizedBox(
                height: 50,
                width: 100,
                child: MaterialButton(
                  color: Colors.red,
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    print('Delete!');
                    setState(() {
                      _selectedRowKeys.forEach((e) {
                        Map<String, dynamic> d = data
                            .where((element) => element['kodebarang'] == e)
                            .first;
                        data.remove(d);
                      });
                      _selectedRowKeys.clear();
                    });
                  },
                ),
              ),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'increment search...',
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFCCCCCC),
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFCCCCCC),
                    ),
                  ),
                ),
                onChanged: (text) {
                  _filterTexts = text.trim().split(' ');
                  _willSearch = false;
                  _latestTick = _timer?.tick;
                },
              ),
            ),
          ],
          source: WebDataTableSource(
            sortColumnName: _sortColumnName,
            sortAscending: _sortAscending,
            filterTexts: _filterTexts,
            columns: [
              WebDataColumn(
                name: 'no',
                label: const Text('No'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              // ###########################################################
              // #####################-  Time Stamp  -######################
              // ###########################################################
              WebDataColumn(
                name: 'timestamp',
                label: const Text('waktu input'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              WebDataColumn(
                name: 'bulan',
                label: const Text('Bulan'),
                dataCell: (value) => DataCell(Text('${getMonth(value)}')),
              ),
              WebDataColumn(
                name: 'category',
                label: const Text('Kategori'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              WebDataColumn(
                name: 'kodebarang',
                label: const Text('Kode Barang'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              WebDataColumn(
                name: 'namabarang',
                label: const Text('Nama Barang'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              WebDataColumn(
                name: 'namabarang',
                label: const Text('Action'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
            ],
            rows: data,
            selectedRowKeys: _selectedRowKeys,
            onTapRow: (rows, index) {
              print('onTapRow(): index = $index, row = ${rows[index]}');
            },
            onSelectRows: (keys) {
              print('onSelectRows(): count = ${keys.length} keys = $keys');
              setState(() {
                _selectedRowKeys = keys;
              });
            },
            primaryKeyName: 'kodebarang',
          ),
          horizontalMargin: 100,
          onPageChanged: (offset) {
            print('onPageChanged(): offset = $offset');
          },
          onSort: (columnName, ascending) {
            print('onSort(): columnName = $columnName, ascending = $ascending');
            setState(() {
              _sortColumnName = columnName;
              _sortAscending = ascending;
            });
          },
          onRowsPerPageChanged: (rowsPerPage) {
            print('onRowsPerPageChanged(): rowsPerPage = $rowsPerPage');
            setState(() {
              if (rowsPerPage != null) {
                _rowsPerPage = rowsPerPage;
              }
            });
          },
          rowsPerPage: _rowsPerPage,
        ),
      ),
    );
  }
}




// import 'package:data_table_2/data_table_2.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter/rendering.dart';

// /// Example without a datasource
// class Input extends StatelessWidget {
//   const Input();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         children: [
//           Container(

//             child: Text('Input Data',
//                 style: TextStyle(
//                   color: Colors.grey.shade700,
//                   fontSize: 50,
//                 )),
//           ),
//           Container(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: DataTable2(
//                   columnSpacing: 12,
//                   horizontalMargin: 12,
//                   minWidth: 600,
//                   columns: [
//                     DataColumn2(
//                       label: Text('Column A'),
//                       size: ColumnSize.L,
//                     ),
//                     DataColumn(
//                       label: Text('Column B'),
//                     ),
//                     DataColumn(
//                       label: Text('Column C'),
//                     ),
//                     DataColumn(
//                       label: Text('Column D'),
//                     ),
//                     DataColumn(
//                       label: Text('Column NUMBERS'),
//                       numeric: true,
//                     ),
//                   ],
//                   rows: List<DataRow>.generate(
//                       100,
//                       (index) => DataRow(cells: [
//                             DataCell(Text('A' * (10 - index % 10))),
//                             DataCell(Text('B' * (10 - (index + 3) % 10))),
//                             DataCell(Text('C' * (15 - (index + 3) % 10))),
//                             DataCell(Text('D' * (15 - (index + 3) % 10))),
//                             DataCell(Text(((index + 0.1) * 25.4).toString()))
//                           ]))),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
