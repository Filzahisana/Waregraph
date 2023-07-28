import 'package:flutter/material.dart';
import 'package:waregraph/services/auth/auth.dart';
import 'package:waregraph/view/components/dashboard_navigation_bar.dart';
import 'package:waregraph/view/pages/dashboard/dashboard.dart';
import 'package:waregraph/view/pages/input/input.dart';
import 'package:waregraph/view/pages/meter/meter.dart';
import 'package:waregraph/view/pages/pipa_besar/pipa_besar.dart';
import 'package:waregraph/view/pages/pipa_kecil/pipa_kecil.dart';

// ###########################################################
// #####################- NAVBAR GA DIPAKE  -######################
// ###########################################################

class MainWaregraphLayout extends StatefulWidget {
  const MainWaregraphLayout({super.key});

  @override
  State<MainWaregraphLayout> createState() => _MainWaregraphLayoutState();
}

class _MainWaregraphLayoutState extends State<MainWaregraphLayout> {
  NavigationBarController controller = NavigationBarController();
  bool isMoreBody = false;
  Widget moreBody = Container();
  List<DashboardNavigationBarItem> pages = [
    DashboardNavigationBarItem('Dashboard',
        leadingIcon: const Icon(
          Icons.home,
          color: Colors.white,
        ),
        pageBody: Dashboard()),
    // DashboardNavigationBarItem('Diagram',
    //     leadingIcon: const Icon(
    //       Icons.bar_chart_rounded,
    //       color: Colors.white,
    //     ),
    // moreBarItems: [
    //   MoreBarItem('Pipa Kecil', itemId: "goToPipaKecilPage"),
    //   MoreBarItem('Pipa Besar', itemId: 'goToPipaBesarPage'),
    // ],
    // pageBody: PipaKecil()),
    DashboardNavigationBarItem('Pipa Kecil',
        leadingIcon: const Icon(
          Icons.circle_outlined,
          color: Colors.white,
        ),
        pageBody: PipaKecil()),
    DashboardNavigationBarItem('Pipa Besar',
        leadingIcon: const Icon(
          Icons.circle,
          color: Colors.white,
        ),
        pageBody: PipaBesar()),
    DashboardNavigationBarItem('Meter',
        leadingIcon: const Icon(
          Icons.electric_meter_rounded,
          color: Colors.white,
        ),
        // moreBarItems: [
        //   MoreBarItem('Input Data',
        //       itemId: 'menujuInputData',
        //       leadingIcon: Icon(
        //         Icons.library_add_rounded,
        //         color: Color.fromARGB(255, 123, 31, 162),
        //       ))
        // ],
        pageBody: Meter()),
    DashboardNavigationBarItem('Input Data',
        leadingIcon: const Icon(
          Icons.library_add_rounded,
          color: Colors.white,
        ),
        // moreBarItems: [
        //   MoreBarItem('Input Data',
        //       itemId: 'menujuInputData',
        //       leadingIcon: Icon(
        //         Icons.library_add_rounded,
        //         color: Color.fromARGB(255, 123, 31, 162),
        //       ))
        // ],
        pageBody: Input()),
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardNavigationBar(
      controller: controller,
      onMoreItemTap: (itemId) {
        print("selected more item id is $itemId");
        if (itemId == 'goToPipaKecilPage') {
          moreBody = PipaKecil();
          isMoreBody = true;
        }
        if (itemId == 'goToPipaBesarPage') {
          moreBody = PipaBesar();
          isMoreBody = true;
        }
        if (itemId == 'menujuInputData') {
          moreBody = Input();
          isMoreBody = true;
        }
        setState(() {});
      },
      onMenuSelected: (index) {
        print("Selected Menu is ${controller.selectedMenuIndex}");
        print("Selected Menu is ${pages[index].title}");
        isMoreBody = false;
        setState(() {});
      },
      body:
          isMoreBody ? moreBody : pages[controller.selectedMenuIndex].pageBody,
      items: pages,
    );
  }
}
