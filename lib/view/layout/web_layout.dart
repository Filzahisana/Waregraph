import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:waregraph/view/pages/dashboard/dashboard.dart';
import 'package:waregraph/view/pages/input/input.dart';
import 'package:waregraph/view/pages/login/login.dart';
import 'package:waregraph/view/pages/meter/meter.dart';
import 'package:waregraph/view/pages/pipa_besar/pipa_besar.dart';
import 'package:waregraph/view/pages/pipa_kecil/pipa_kecil.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({
    super.key,
  });

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  int selectedIndex = 0;
  SidebarXController? sidebarXController;
  final _key = GlobalKey<ScaffoldState>();
  bool onExtend = true;
  List<Page> listPages = [
    Page(page: Dashboard(), icon: Icons.home_rounded, title: "Dashboard"),
    Page(page: PipaKecil(), icon: Icons.ac_unit_outlined, title: "Pipa Kecil"),
    Page(page: PipaBesar(), icon: Icons.ac_unit_outlined, title: "Pipa Besar"),
    Page(page: Meter(), icon: Icons.ac_unit_outlined, title: "Meter "),
    Page(page: Input(), icon: Icons.ac_unit_outlined, title: "Input Data "),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onInit();
  }

  void onInit() {
    SidebarXController ctrl =
        SidebarXController(selectedIndex: selectedIndex, extended: true);
    setState(() {
      sidebarXController = ctrl;
    });
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
        key: _key,
        drawer: Drawer(
          child: Column(
            children: [],
          ),
        ),
        appBar: isSmallScreen
            ? AppBar(
                backgroundColor: Colors.white,
                title: Text(listPages[selectedIndex].title),
                leading: IconButton(
                  onPressed: () {
                    // if (!Platform.isAndroid && !Platform.isIOS) {
                    //   _controller.setExtended(true);
                    // }
                    _key.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.abc),
                ),
              )
            : null,
        body: Row(
          children: [
            sidebarXController == null
                ? Container()
                : !isSmallScreen
                    ? SidebarX(
                        headerBuilder: (context, extended) => Container(
                          margin: EdgeInsets.only(bottom: 120, top: 30),
                          child: Image.asset('assets/Logo Putih.jpg'),
                          width: 120,
                        ),
                        // toggleButtonBuilder: (context, value) {
                        //   return IconButton(
                        //     onPressed: () {
                        //       value = !value;
                        //       setState(() {
                        //         onExtend = value;
                        //       });
                        //     },
                        //     icon: Icon(
                        //       value
                        //           ? Icons.arrow_back_ios_new_rounded
                        //           : Icons.arrow_forward_ios_rounded,
                        //       color: value
                        //           ? Colors.white
                        //           : Colors.blueGrey.shade700,
                        //     ),
                        //   );
                        // },

                        footerBuilder: (context, isExtend) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    },
                                    icon: Icon(
                                      Icons.logout_outlined,
                                      color: Colors.white,
                                    )),
                                isExtend
                                    ? Text(
                                        'Logout',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          );
                        },
                        controller: sidebarXController!,
                        theme: SidebarXTheme(
                            padding: EdgeInsets.zero,
                            iconTheme: IconThemeData(color: Colors.white),
                            hoverTextStyle: TextStyle(color: Colors.white),
                            textStyle: TextStyle(color: Colors.white),
                            selectedItemDecoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            selectedTextStyle: TextStyle(
                                color: const Color.fromARGB(255, 51, 41, 124)),
                            selectedIconTheme: IconThemeData(
                                color: const Color.fromARGB(255, 51, 41, 124)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(255, 51, 41, 124))),
                        extendedTheme: SidebarXTheme(
                            padding: EdgeInsets.zero,
                            iconTheme: IconThemeData(color: Colors.white),
                            hoverTextStyle: TextStyle(color: Colors.white),
                            textStyle: TextStyle(color: Colors.white),
                            width: 180,
                            selectedItemDecoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            selectedTextStyle: TextStyle(
                                color: const Color.fromARGB(255, 51, 41, 124)),
                            selectedIconTheme: IconThemeData(
                                color: const Color.fromARGB(255, 51, 41, 124)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(255, 51, 41, 124))),
                        items: listPages
                            .map((e) => SidebarXItem(
                                label: e.title,
                                iconWidget: Row(
                                  children: [
                                    Icon(
                                      e.icon,
                                      color:
                                          listPages.indexOf(e) == selectedIndex
                                              ? Color.fromARGB(255, 51, 41, 124)
                                              : Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    )
                                  ],
                                ),
                                // icon: e.icon,
                                onTap: () {
                                  changeIndex(listPages.indexOf(e));
                                }))
                            .toList(),
                      )
                    : SizedBox(),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: listPages[selectedIndex].page)
          ],
        ));
  }
}

class Page {
  final Widget page;
  final IconData icon;
  final String title;

  Page({required this.page, required this.icon, required this.title});
}
