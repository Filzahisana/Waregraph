import 'package:flutter/material.dart';
import 'package:waregraph/view/layout/web_layout.dart';
// import 'package:waregraph/view/pages/login/login.dart';

void main() {
  runApp(Waregraph());
}

class Waregraph extends StatelessWidget {
  const Waregraph({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Waregraph",
      home: WebLayout(),
    );
  }
}
