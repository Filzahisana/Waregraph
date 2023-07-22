import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waregraph/view/layout/size.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget(
      {Key? key, this.onChanged, this.controller, this.useShadow = false})
      : super(key: key);

  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final bool? useShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.getWidthFromPrecentage(context, 1),
          vertical: 10),
      width: Responsive.getWidthFromPrecentage(context, 18),
      height: 50,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: !useShadow!
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 45,
            width: Responsive.getWidthFromPrecentage(context, 14),
            child: TextField(
              onChanged: onChanged,
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Cari',
              ),
              onSubmitted: (String value) async {
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thanks!'),
                      content: Text(
                          'You typed "$value". \n This Widget is on going'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          SvgPicture.asset(
            'assets/icons/Search.svg',
            color: Colors.blueGrey,
            height: 18,
          )
        ],
      ),
    );
  }
}
