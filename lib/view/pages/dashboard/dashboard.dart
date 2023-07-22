import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waregraph/view/layout/size.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<_SalesData> data = [
    _SalesData('2001', 35),
    _SalesData('2002', 28),
    _SalesData('2003', 34),
    _SalesData('2004', 32),
    _SalesData('2005', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            child: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Top Item With Red Code Stock Status',
                    style: GoogleFonts.nunito(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: Colors.blueGrey.shade800),
                  ),
                  // style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     letterSpacing: 2.0,
                  //     color: Colors.blueGrey.shade800,
                  //     fontSize: 25),
                  // ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 220,
                width: 420,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
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
                          yValueMapper: (_SalesData sales, _) => sales.sales,
                          name: 'Stock',
                          // Enable data label
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true))
                    ]),
              ),
              Container(
                height: 220,
                width: 420,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
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
                          yValueMapper: (_SalesData sales, _) => sales.sales,
                          name: 'Stock',
                          // Enable data label
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true))
                    ]),
              ),
              Container(
                height: 220,
                width: 420,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
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
                          yValueMapper: (_SalesData sales, _) => sales.sales,
                          name: 'Stock',
                          // Enable data label
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true))
                    ]),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          SizedBox(
            child: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'All Items Stock',
                    style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.displayLarge,
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
                  padding:
                      EdgeInsets.only(right: 40, left: 20, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  // margin: EdgeInsets.symmetric(vertical: 20),
                  height: 300,
                  width: Responsive.getWidthFromPrecentage(context, 90),
                  child: SfCartesianChart(series: <ChartSeries>[
                    // Renders column chart
                    ColumnSeries<_SalesData, double>(
                        color: const Color.fromARGB(255, 51, 41, 124),
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) =>
                            double.parse(sales.year),
                        yValueMapper: (_SalesData sales, _) => sales.sales),
                  ])),
            ],
          ),
        ]),
      ),
    );
  }
}

class DashChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DashChart({Key? key}) : super(key: key);

  @override
  State<DashChart> createState() => _DashChartState();
}

class _DashChartState extends State<DashChart> {
  List<_SalesData> data = [
    _SalesData('2001', 35),
    _SalesData('2002', 28),
    _SalesData('2003', 34),
    _SalesData('2004', 32),
    _SalesData('2005', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          //Initialize the chart widget
          Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 300,
              width: 500,
              child: SfCartesianChart(series: <ChartSeries>[
                // Renders column chart
                ColumnSeries<_SalesData, double>(
                    color: const Color.fromARGB(255, 51, 41, 124),
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) =>
                        double.parse(sales.year),
                    yValueMapper: (_SalesData sales, _) => sales.sales),
              ])),
          Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 300,
              width: 500,
              child: SfCartesianChart(series: <ChartSeries>[
                // Renders column chart
                ColumnSeries<_SalesData, double>(
                    color: const Color.fromARGB(255, 51, 41, 124),
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) =>
                        double.parse(sales.year),
                    yValueMapper: (_SalesData sales, _) => sales.sales),
              ])),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Half yearly sales analysis'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]),
        ]),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
