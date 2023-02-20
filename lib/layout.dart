import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:waregraph/size.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({super.key});

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  get decoration => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 15,
            left: 150,
            child: Container(
                // color: Colors.black45,
                width: SizeControl.getWidthFromPrencentage(
                    context: context, percent: 90),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 500,
                      height: 30,
                      child: Row(
                        children: [
                          Icon(
                            Feather.search,
                            color: Colors.black54,
                            size: 15,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                    Icon(
                      Feather.bell,
                      color: Colors.black38,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Row(
                          children: [
                            // profil
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Positioned(
              top: SizeControl.getHeightFromPrencentage(
                  context: context, percent: 2),
              bottom: SizeControl.getHeightFromPrencentage(
                  context: context, percent: 2),
              left: SizeControl.getWidthFromPrencentage(
                  context: context, percent: 2),
              child: Container(
                  // padding: EdgeInsets.symmetric(
                  //     vertical: SizeControl.getHeightFromPrencentage(
                  //         context: context, percent: 5),
                  //     horizontal: SizeControl.getWidthFromPrencentage(
                  //         context: context, percent: 3)),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 51, 41, 124),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: SizeControl.getHeightFromPrencentage(
                      context: context, percent: 100),
                  width: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(30),
                      //       color: Color.fromARGB(255, 255, 255, 255),
                      //       boxShadow: const [
                      //         BoxShadow(
                      //             offset: Offset(-28, -28),
                      //             color: Color.fromARGB(255, 255, 255, 255))
                      //       ]),
                      // ),
                      Image.asset(
                        'images/logoputih.jpg',
                        // width: 150,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      Container(
                        height: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              MaterialCommunityIcons.home,
                              color: Colors.white,
                            ),
                            Icon(
                              MaterialCommunityIcons.pipe_disconnected,
                              color: Colors.white,
                            ),
                            Icon(
                              MaterialCommunityIcons.pipe,
                              color: Colors.white,
                            ),
                            Icon(
                              MaterialCommunityIcons.pipe_valve,
                              color: Colors.white,
                            ),
                            Icon(
                              Feather.wind,
                              color: Colors.white,
                            ),
                            Icon(
                              Feather.bar_chart,
                              // MaterialCommunityIcons.chart_line_variant,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Feather.settings,
                        // MaterialCommunityIcons.nut,
                        color: Colors.white,
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
