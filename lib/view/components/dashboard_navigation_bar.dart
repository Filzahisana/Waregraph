import 'package:flutter/material.dart';
import 'package:waregraph/view/components/mouse_handler.dart';
import 'package:waregraph/view/layout/size.dart';

class DashboardNavigationBar extends StatefulWidget {
  const DashboardNavigationBar(
      {super.key,
      this.body,
      required this.items,
      this.onMoreItemTap,
      this.controller,
      this.onMenuSelected,
      this.theme});
  final Widget? body;
  final Function(int index)? onMenuSelected;
  final List<DashboardNavigationBarItem> items;
  final Function(String itemId)? onMoreItemTap;
  final NavigationBarController? controller;
  final NavigationBarTheme? theme;

  @override
  State<DashboardNavigationBar> createState() => _DashboardNavigationBarState();
}

class _DashboardNavigationBarState extends State<DashboardNavigationBar> {
  bool isNavbarExpanded = false;
  List<UnExpandedItem> unExpandedItems = [];
  double initialUnExpandedItemTopSize = 240;

  void expandNavbar() {
    if (!isNavbarExpanded) {
      setState(() {
        isNavbarExpanded = true;
      });
    } else {
      setState(() {
        isNavbarExpanded = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    onInit();
    widget.controller?.addListener(() {
      if (widget.controller?.isExpand == true && isNavbarExpanded) {
        setState(() {
          isNavbarExpanded = false;
        });
      }
      if (widget.controller?.isExpand == false && !isNavbarExpanded) {
        setState(() {
          isNavbarExpanded = true;
        });
      }
    });
    super.initState();
  }

  void onInit() {
    List<UnExpandedItem> items = [];
    double size = initialUnExpandedItemTopSize;
    for (var i = 0; i < widget.items.length; i++) {
      print(size);
      items.add(UnExpandedItem(
          topSize: size,
          item: NavbarItem(
            onTap: () {
              if (widget.onMenuSelected != null) {
                widget.onMenuSelected!(i);
                if (widget.controller != null) {
                  widget.controller!.selectedMenuIndex = i;
                }
              }
            },
            title: widget.items[i].title,
            icon: widget.items[i].leadingIcon ??
                const Icon(
                  Icons.dashboard_rounded,
                  color: Colors.white,
                ),
            expandedItem: widget.items[i].moreBarItems
                ?.map((e) => PopupMenuItem(
                      value: e.itemId,
                      child: SizedBox(
                        // width: 200, //*width of popup
                        child: Row(
                          children: [
                            e.leadingIcon ??
                                Icon(
                                  Icons.book_online_rounded,
                                  color: const Color.fromARGB(255, 51, 41, 124),
                                ),
                            const SizedBox(width: 10.0),
                            Text(e.title)
                          ],
                        ),
                      ),
                      onTap: () {
                        if (widget.onMoreItemTap != null) {
                          widget.controller?.selectedMoreItemId = e.itemId;
                          widget.onMoreItemTap!(e.itemId);
                        }
                      },
                    ))
                .toList(),
          )));
      size = size + 55;
    }
    setState(() {
      unExpandedItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(181, 209, 187, 222),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                // left: 1
                left: isNavbarExpanded
                    ? Responsive.getWidthFromPrecentage(context, 16)
                    : Responsive.getWidthFromPrecentage(context, 8)),
            child: widget.body,
          ),
          AnimatedContainer(
            clipBehavior: Clip.hardEdge,
            transformAlignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            duration: const Duration(milliseconds: 350),
            margin: const EdgeInsets.only(top: 50, bottom: 50, left: 15),
            width: isNavbarExpanded ? 192 : 80,
            height: Responsive.getHeightFromPrecentage(context, 85),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 51, 41, 124),
              // ####################### Warna navbar #######################################################
              // ############################################################################################
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(-1, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // replace icon with image
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: const Icon(
                      //       Icons.menu_rounded,
                      //       color: Colors.white,
                      //     )),
                      InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/Logo Putih.jpg',
                            width: 75,
                            height: 75,
                            alignment: Alignment.center,
                          )),
                      if (isNavbarExpanded)
                        const SizedBox(
                          width: 2,
                        ),
                      if (isNavbarExpanded)
                        const Text(
                          'Waregraph',
                          style: TextStyle(color: Colors.white),
                        ),
                    ],
                  ),
                ),
                if (isNavbarExpanded)
                  SizedBox(
                    height: 350,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.items
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      if (widget.onMenuSelected != null) {
                                        widget.onMenuSelected!(
                                            widget.items.indexOf(e));
                                        if (widget.controller != null) {
                                          widget.controller!.selectedMenuIndex =
                                              widget.items.indexOf(e);
                                        }
                                      }
                                    },
                                    // splashColor:
                                    //     widget.theme?.itemMenuSplashColor,
                                    child: NavbarItem(
                                      selectedMoreItemId: (value) {
                                        if (widget.onMoreItemTap != null) {
                                          widget.controller
                                              ?.selectedMoreItemId = value;
                                          widget.onMoreItemTap!(value);
                                        }
                                      },
                                      moreBarItems: e.moreBarItems,
                                      isNavbarExpanded: isNavbarExpanded,
                                      title: e.title,
                                      icon: e.leadingIcon ??
                                          const Icon(Icons.dashboard_rounded),
                                      expandedNavbarIconTheme:
                                          widget.theme?.expandedIconTheme ??
                                              NavbarIconTheme(),
                                    ),
                                  ))
                              .toList(),
                          // children: [
                          //   NavbarItem(
                          //       isNavbarExpanded: isNavbarExpanded,
                          //       title: 'Dashboard',
                          //       icon: Icon(
                          //         Icons.dashboard_rounded,
                          //         color: Colors.white,
                          //       )),
                          //   NavbarItem(
                          //       isNavbarExpanded: isNavbarExpanded,
                          //       title: 'Charts',
                          //       icon: Icon(
                          //         Icons.bar_chart_rounded,
                          //         color: Colors.white,
                          //       ))
                          // ],
                        ),
                      ),
                    ),
                  ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.account_circle_rounded,
                                color: Colors.white,
                              )),
                          if (isNavbarExpanded)
                            const Text(
                              'Laura Enigma',
                              style: TextStyle(color: Colors.white),
                            ),
                          if (isNavbarExpanded)
                            IconButton(
                                onPressed: expandNavbar,
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: 13,
                                )),
                        ],
                      ),
                      // SizedBox(
                      //   height: 1,
                      // ),
                      if (!isNavbarExpanded)
                        IconButton(
                            onPressed: expandNavbar,
                            icon: Icon(
                              isNavbarExpanded
                                  ? Icons.arrow_back_ios_new_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 13,
                            )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isNavbarExpanded)
            ...unExpandedItems
                .map((e) => Positioned(
                      top: e.topSize,
                      left: 38,
                      child: e.item,
                    ))
                .toList(),
          // Positioned(
          //   top: 240,
          //   left: 16,
          //   child: NavbarItem(
          //       title: 'Home',
          //       icon: Icon(
          //         Icons.dashboard,
          //         color: Colors.white,
          //       )),
          // ),
          // if (!isNavbarExpanded)
          //   Positioned(
          //     top: 295,
          //     left: 16,
          //     child: NavbarItem(
          //       title: 'Chart',
          //       icon: Icon(
          //         Icons.bar_chart_rounded,
          //         color: Colors.white,
          //       ),
          //       expandedItem: [
          //         PopupMenuItem(
          //           child: Text("Chart 1"),
          //         ),
          //         PopupMenuItem(
          //           child: Text("Chart 2"),
          //         ),
          //         PopupMenuItem(
          //           child: Text("Chart 3"),
          //         ),
          //       ],
          //     ),
          //   )
        ],
      ),
    );
  }
}

class NavbarItem extends StatefulWidget {
  const NavbarItem(
      {super.key,
      required this.title,
      required this.icon,
      this.expandedItem,
      this.isNavbarExpanded = false,
      this.expandedNavbarIconTheme,
      this.selectedMoreItemId,
      this.onTap,
      this.moreBarItems});
  final String title;
  final Icon icon;
  final List<PopupMenuEntry<String>>? expandedItem;
  final List<MoreBarItem>? moreBarItems;
  final bool? isNavbarExpanded;
  final NavbarIconTheme? expandedNavbarIconTheme;
  final Function(String value)? selectedMoreItemId;
  final Function()? onTap;

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  bool hoveredNavbarItem = false;
  // bool isTextActivated = false;
  bool expandedNavbarIsHovered = false;
  bool isMoreItemHiglighted = false;
  bool isMoreItemAvailable = false;
  bool isItemExpanded = false;
  List<MoreBarItem> expandedItems = [];

  @override
  void initState() {
    super.initState();
    onInit();
  }

  onInit() {
    setState(() {
      expandedItems = widget.moreBarItems ?? [];
    });
    print(expandedItems.length);
  }

  void hovNavbar() {
    if (!hoveredNavbarItem) {
      print('expanding navbar');
      setState(() {
        hoveredNavbarItem = true;
      });
      // Future.delayed(const Duration(milliseconds: 200), () {

      // });
    }
  }

  void unHovNavbar() {
    print('decreasing navbar size');
    setState(() {
      hoveredNavbarItem = false;
      // isTextActivated = false;
    });
  }

  void expandedNavbarHoveredNavbarItem() {
    if (!expandedNavbarIsHovered) {
      setState(() {
        expandedNavbarIsHovered = true;
      });
    }
  }

  void expandedNavbarUnHoveredNavbarItem() {
    if (expandedNavbarIsHovered) {
      setState(() {
        expandedNavbarIsHovered = false;
      });
    }
  }

  Widget expandItem() {
    print(expandedItems.length);
    if (expandedItems.isNotEmpty) {
      return IconButton(
        onPressed: () {
          setState(() {
            isItemExpanded = !isItemExpanded;
          });
        },
        icon: RotationTransition(
          turns: AlwaysStoppedAnimation(isItemExpanded == true ? 90 / 360 : 0),
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
            size: 12,
          ),
        ),
      );
    } else {
      return const SizedBox(
        width: 15,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isNavbarExpanded!) {
      return HandCursor(
          onHover: expandedNavbarHoveredNavbarItem,
          onExit: expandedNavbarUnHoveredNavbarItem,
          child: AnimatedContainer(
            clipBehavior: Clip.hardEdge,
            transformAlignment: Alignment.centerLeft,
            duration: const Duration(milliseconds: 350),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            height: isItemExpanded ? 100 + (expandedItems.length * 35) : 50,
            width: 170,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 51, 41, 124),
                // borderRadius: BorderRadius.circular(15),
                border: expandedNavbarIsHovered
                    ? const Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(240, 255, 255, 255)))
                    : null
                // boxShadow: expandedNavbarIsHovered
                //     ? [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.5),
                //           spreadRadius: 1,
                //           blurRadius: 3,
                //           offset:
                //               const Offset(-1, 1), // changes position of shadow
                //         ),
                //       ]
                //     : null,
                ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        widget.icon.icon,
                        size: widget.expandedNavbarIconTheme?.size,
                        color: expandedNavbarIsHovered
                            ? widget.expandedNavbarIconTheme?.hoveredColor ??
                                Colors.white
                            : widget.expandedNavbarIconTheme?.color ??
                                const Color.fromARGB(255, 204, 204, 204),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: expandedNavbarIsHovered
                                  ? Colors.white
                                  : Colors.white60),
                        ),
                      ),
                      expandItem()
                    ],
                  ),
                  if (isItemExpanded)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 36, 8, 41),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: widget.moreBarItems!
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      widget.selectedMoreItemId!(e.itemId);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                e.leadingIcon?.icon ??
                                                    Icons.ac_unit_rounded,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                e.title,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 55,
                                            child: Divider(
                                              thickness: 0.2,
                                              color: Color.fromARGB(
                                                  223, 255, 255, 255),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ));
    } else {
      return HandCursor(
          onHover: () => hovNavbar(),
          onExit: () => unHovNavbar(),
          child: GestureDetector(
            onTap: () {
              if (widget.onTap != null) widget.onTap!();
            },
            child: AnimatedContainer(
              transformAlignment: Alignment.centerLeft,
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              onEnd: () {
                // if (!hoveredNavbarItem) {
                print('opening expanded navbar item');
                // setState(() {
                //   isTextActivated = true;
                // });
                // } else {
                //   print('opening expanded navbar item');
                //   setState(() {
                //     isTextActivated = false;
                //   });
                // }
              },
              duration: const Duration(milliseconds: 350),
              margin: EdgeInsets.only(
                  left: hoveredNavbarItem || isMoreItemHiglighted == true
                      ? 7
                      : 0),
              // width: hoveredNavbarItem ? 150 : 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 51, 41, 124),
                // ######################### IconBox ##################################################
                // ####################################################################################
                borderRadius: BorderRadius.circular(15),
                boxShadow: hoveredNavbarItem || isMoreItemHiglighted == true
                    ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                              const Offset(-1, 1), // changes position of shadow
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: Icon(
                        widget.icon.icon,
                        color: Colors.white,
                      )),
                  if (hoveredNavbarItem || isMoreItemHiglighted == true)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            color:
                                // hoveredNavbarItem
                                // ? Color.fromARGB(255, 36, 8, 41) :
                                Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if ((hoveredNavbarItem && widget.expandedItem != null) ||
                      isMoreItemHiglighted == true)
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 10),
                      child: HandCursor(
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(
                              isMoreItemHiglighted == true ? 90 / 360 : 0),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                        ),
                        onHover: () {
                          _showPopup(context);
                          setState(() {
                            isMoreItemHiglighted = true;
                          });
                        },
                        onExit: () {},
                      ),
                    )
                ],
              ),
            ),
          ));
    }
  }

  // static const Map<String, IconData> _options = {
  //   'Chart 1': Icons.favorite_border,
  //   'Chart 2': Icons.bookmark_border,
  //   'Chart 3': Icons.book_online_rounded,
  // };

  void _showPopup(BuildContext context) async {
    //*get the render box from the context
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    //*get the global position, from the widget local position
    final offset = renderBox.localToGlobal(Offset.zero);

    //*calculate the start point in this case, below the button
    final left = offset.dx;
    final top = offset.dy + renderBox.size.height;
    //*The right does not indicates the width
    final right = left + renderBox.size.width;

    //*show the menu
    final value = await showMenu<String>(

        // color: Colors.red,

        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        context: context,
        position: RelativeRect.fromLTRB(left + 150, top, right, 0.0),
        items: widget.expandedItem!
        // items: _options.entries.map<PopupMenuEntry<String>>((entry) {
        //   return PopupMenuItem(
        //     onTap: () {
        //       setState(() {
        //         isMoreItemHiglighted = false;
        //       });
        //     },
        //     value: entry.key,
        //     child: SizedBox(
        //       // width: 200, //*width of popup
        //       child: Row(
        //         children: [
        //           Icon(entry.value, color: Colors.const Color.fromARGB(255, 51, 41, 124),),
        //           const SizedBox(width: 10.0),
        //           Text(entry.key)
        //         ],
        //       ),
        //     ),
        //   );
        // }).toList()
        );
    if (value == null && widget.selectedMoreItemId != null) {
      widget.selectedMoreItemId!("");
    }
    setState(() {
      isMoreItemHiglighted = false;
    });
  }
}

class NavigationBarTheme {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? itemMenuSplashColor;
  final NavbarIconTheme? expandedIconTheme;
  final NavbarIconTheme? iconTheme;
  final BoxDecoration? decoration;
  final BoxDecoration? expandedDecoration;

  NavigationBarTheme(
      {this.backgroundColor = Colors.teal,
      this.foregroundColor = Colors.white,
      this.itemMenuSplashColor = const Color.fromARGB(255, 176, 190, 197),
      this.expandedIconTheme,
      this.iconTheme,
      this.decoration,
      this.expandedDecoration});
}

class NavbarIconTheme {
  final Color? color;
  final Color? hoveredColor;
  final double? size;
  final Color? selectedColor;

  NavbarIconTheme(
      {this.color = const Color.fromARGB(255, 204, 204, 204),
      this.hoveredColor = const Color.fromARGB(255, 255, 255, 255),
      this.size,
      this.selectedColor});
}

class ExpandedNavbarIconTheme {
  final Color? color;
  final Color? hoveredColor;
  final double? size;
  final Color? selectedColor;

  ExpandedNavbarIconTheme(
      {this.color = const Color.fromARGB(255, 204, 204, 204),
      this.hoveredColor = Colors.white,
      this.size,
      this.selectedColor});
}

class DashboardNavigationBarItem {
  final String title;
  final Icon? leadingIcon;
  final List<MoreBarItem>? moreBarItems;
  final Widget pageBody;

  DashboardNavigationBarItem(this.title,
      {this.leadingIcon, this.moreBarItems, required this.pageBody});
}

class MoreBarItem {
  final String title;
  final Icon? leadingIcon;
  final String itemId;

  MoreBarItem(this.title, {this.leadingIcon, required this.itemId});
}

class UnExpandedItem {
  final double topSize;
  final NavbarItem item;

  UnExpandedItem({
    required this.topSize,
    required this.item,
  });
}

class NavigationBarController extends ChangeNotifier {
  final Function(bool value)? onExpand;

  bool? isExpand;
  int selectedMenuIndex = 1;
  String? selectedMoreItemId;

  NavigationBarController({
    this.onExpand,
  });

  void expandNavbar() {
    isExpand = true;
    notifyListeners();
  }

  void minimizeNavbar() {
    isExpand = false;
    notifyListeners();
  }
}
