import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:waregraph/view/layout/components/searchbar.dart';y
import 'package:waregraph/view/layout/size.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/web_data_table.dart';
import '../input/input.dart';
// import 'package:waregraph/view/pages/dashboard/dashboard.dart';

class PB_DetailItem extends StatefulWidget {
  const PB_DetailItem({super.key, this.onBackTap});
  final Function()? onBackTap;

  @override
  State<PB_DetailItem> createState() => _PB_DetailItemState();
}

class _PB_DetailItemState extends State<PB_DetailItem> {
  List<_SalesData> data = [
    _SalesData('2020', 58),
    _SalesData('2021', 78),
    _SalesData('2022', 62),
    _SalesData('2023', 61),
    _SalesData('2024', 81)
  ];

  Widget namaWidget = Container();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(25),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              if (widget.onBackTap != null) {
                                widget.onBackTap!();
                              }
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.blueGrey.shade700,
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Pipa HDPE - 20',
                          style: GoogleFonts.poppins(
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: Colors.blueGrey.shade800),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 220,
                    width: Responsive.getWidthFromPrecentage(context, 90),
                    // width: Responsive.getWidthFromPrecentage(context, 90),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart title
                        // title: ChartTitle(text: 'Stok Barang Selama Satu Tahun'),
                        // Enable legend
                        legend: Legend(isVisible: true),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<_SalesData, String>>[
                          LineSeries<_SalesData, String>(
                              dataSource: data,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) =>
                                  sales.sales,
                              name: 'Stock',
                              // Enable data label
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true))
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: Responsive.getWidthFromPrecentage(context, 90),
                    margin: EdgeInsets.only(
                        // left: Responsive.getWidthFromPrecentage(context, 10),
                        top: 20,
                        bottom: 30),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [InputDatatables()],
                    ),
                  ),
                ],
              ))),
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

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
