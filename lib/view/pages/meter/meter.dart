import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waregraph/view/layout/components/searchbar.dart';
import 'package:waregraph/view/layout/size.dart';
import 'package:waregraph/view/pages/meter/meter_detailitem.dart';
// import 'package:waregraph/view/pages/dashboard/dashboard.dart';

class Meter extends StatefulWidget {
  const Meter({super.key});

  @override
  State<Meter> createState() => _MeterState();
}

class _MeterState extends State<Meter> {
  Widget detailItem = Meter_DetailItem();
  List<_SalesData> data = [
    _SalesData('2020', 58),
    _SalesData('2021', 78),
    _SalesData('2022', 62),
    _SalesData('2023', 61),
    _SalesData('2024', 81)
  ];
  int? selectedItemId;

  Widget namaWidget = Container();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: selectedItemId != null
              ? Meter_DetailItem(
                  onBackTap: () {
                    setState(() {
                      selectedItemId = null;
                    });
                  },
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Container(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Meter - All Items Stock',
                                style: GoogleFonts.poppins(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    color: Colors.blueGrey.shade800),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(
                                  right: 40, left: 20, top: 20, bottom: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white),
                              // margin: EdgeInsets.symmetric(vertical: 20),
                              height: 250,
                              width: Responsive.getWidthFromPrecentage(
                                  context, 90),
                              child: SfCartesianChart(series: <ChartSeries>[
                                // Renders column chart
                                ColumnSeries<_SalesData, double>(
                                    color:
                                        const Color.fromARGB(255, 51, 41, 124),
                                    dataSource: data,
                                    xValueMapper: (_SalesData sales, _) =>
                                        double.parse(sales.year),
                                    yValueMapper: (_SalesData sales, _) =>
                                        sales.sales),
                              ])),
                        ],
                      ),

                      // Container(
                      //   margin: EdgeInsets.symmetric(vertical: 20),
                      //   height: 300,
                      //   width: MediaQuery.of(context).size.width * 0.9,
                      //   alignment: Alignment.bottomCenter,
                      //   child: SfCartesianChart(
                      //     series: <ChartSeries>[
                      //       ColumnSeries<_SalesData, double>(
                      //           color: const Color.fromARGB(255, 51, 41, 124),
                      //           dataSource: data,
                      //           xValueMapper: (_SalesData sales, _) =>
                      //               double.parse(sales.year),
                      //           yValueMapper: (_SalesData sales, _) => sales.sales)
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(
                            // left: Responsive.getWidthFromPrecentage(context, 1),
                            top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SearchWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            gridview(
                              width: Responsive.getWidthFromPrecentage(
                                  context, 90),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))),
    );
  }

  Widget gridview({double? width}) {
    onTap() {
      selectedItemId = 1;
      setState(() {});
    }

    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      height: 200,
      width: width ?? 1200,
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 20,
          mainAxisSpacing: 8,
          crossAxisCount: 5,
          childAspectRatio: 60 / 10,
          children: List.generate(
            20,
            (index) => GridViewItem(
              onTap: onTap,
              itemData: {'name': 'PVC', 'code': '1076-pipa-longgar'},
            ),
          ).toList()),
    );
  }
}

class GridViewItem extends StatefulWidget {
  GridViewItem({
    super.key,
    required this.onTap,
    required this.itemData,
  });

  final Function() onTap;
  final Map<String, dynamic> itemData;

  @override
  State<GridViewItem> createState() => _GridViewItemState();
}

class _GridViewItemState extends State<GridViewItem> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onTap,
      // padding: const EdgeInsets.all(8),
      // color: const Color.fromARGB(255, 51, 41, 124),
      child: Text("Nama Barang ${widget.itemData['name']}",
          style: TextStyle(color: Colors.blueGrey.shade900)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
