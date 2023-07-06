import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:waregraph/view/layout/web_layout.dart';
import 'package:waregraph/view/pages/dashboard/dashboard.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: 'ECORP',
      // logo: AssetImage('assets/images/ecorp-lightgreen.png'),
      onLogin: (value) {
        print(value);
      },
      onSignup: (_) => Future(() => null),

      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => WebLayout(),
        ));
      },
      onRecoverPassword: (_) => Future(() => null),
      theme: LoginTheme(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        errorColor: Colors.red,
        titleStyle: TextStyle(
          color: const Color.fromARGB(255, 51, 41, 124),
          fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
        bodyStyle: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: TextStyle(
          color: const Color.fromARGB(255, 51, 41, 124),
          // shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(255, 51, 41, 124).withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: Colors.grey.shade300,
            color: Colors.grey.shade700,
          ),
          labelStyle: TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 51, 41, 124), width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 51, 41, 124), width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade50, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: const Color.fromARGB(255, 51, 41, 124),
          highlightColor: Color.fromARGB(255, 82, 70, 172),
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
    );
  }
}
