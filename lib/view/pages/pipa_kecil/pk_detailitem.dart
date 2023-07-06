import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waregraph/view/layout/components/searchbar.dart';
import 'package:waregraph/view/layout/size.dart';
// import 'package:waregraph/view/pages/dashboard/dashboard.dart';

class PK_DetailItem extends StatefulWidget {
  const PK_DetailItem({super.key});

  @override
  State<PK_DetailItem> createState() => _PK_DetailItemState();
}

class _PK_DetailItemState extends State<PK_DetailItem> {
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
                    margin: EdgeInsets.symmetric(vertical: 20),
                    height: 300,
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.bottomCenter,
                    child: SfCartesianChart(
                      series: <ChartSeries>[
                        ColumnSeries<_SalesData, double>(
                            color: const Color.fromARGB(255, 51, 41, 124),
                            dataSource: data,
                            xValueMapper: (_SalesData sales, _) =>
                                double.parse(sales.year),
                            yValueMapper: (_SalesData sales, _) => sales.sales)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: Responsive.getWidthFromPrecentage(context, 10),
                        top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SearchWidget(),
                        gridview(),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }

  Widget gridview() {
    return SizedBox(
      height: 600,
      width: 1200,
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          crossAxisCount: 4,
          childAspectRatio: 1200 / 600,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              color: const Color.fromARGB(255, 51, 41, 124),
              child:
                  const Text('JADI APA', style: TextStyle(color: Colors.white)),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: const Color.fromARGB(255, 51, 41, 124),
              child:
                  const Text('JADI APA', style: TextStyle(color: Colors.white)),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: const Color.fromARGB(255, 51, 41, 124),
              child: const Text(
                'JADI APA',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: const Color.fromARGB(255, 51, 41, 124),
              child: const Text('aJADI APA',
                  style: TextStyle(color: Colors.white)),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: const Color.fromARGB(255, 51, 41, 124),
              child:
                  const Text('JADI APA', style: TextStyle(color: Colors.white)),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: const Color.fromARGB(255, 51, 41, 124),
              child:
                  const Text('JADI APA', style: TextStyle(color: Colors.white)),
            )
          ]),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
