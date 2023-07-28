import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:waregraph/services/auth/auth.dart';
import 'package:waregraph/services/auth/wrapper.dart';
import 'package:waregraph/services/data/provider/user_provider.dart';
import 'package:waregraph/view/layout/size.dart';
import 'package:waregraph/view/layout/web_layout.dart';
// import 'package:waregraph/view/pages/dashboard/dashboard.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoginWithEmailPassword = false;
  bool onSync = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return !isLoginWithEmailPassword
        ? Scaffold(
            backgroundColor: Color.fromARGB(255, 232, 232, 238),
            body: Center(
              child: Container(
                width: Responsive.getWidthFromPrecentage(
                    context, Responsive.isDesktop(context) ? 35 : 80),
                height: Responsive.getHeightFromPrecentage(
                    context, Responsive.isDesktop(context) ? 35 : 70),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(-1, 1), // changes position of shadow
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: onSync
                    ? CircularProgressIndicator(
                        color: Colors.purple.shade700,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login Menggunakan : ',
                            style: TextStyle(
                                color: Colors.blueGrey.shade800, fontSize: 12),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                              // shape: const CircleBorder(eccentricity: 0.0),
                              // height: Responsive.getHeightFromPrecentage(
                              //     context, Responsive.isDesktop(context) ? 10 : 20),
                              // minWidth: Responsive.getHeightFromPrecentage(
                              //     context, Responsive.isDesktop(context) ? 10 : 20),
                              onTap: () async {
                                setState(() {
                                  onSync = true;
                                });
                                User? user =
                                    await AuthServices.signInWithGoogle();
                                if (user != null) {
                                  print('Logged In using google account');
                                  if (userProvider.isExists != null) {
                                    userProvider.onInit();
                                  }
                                  setState(() {
                                    onSync = false;
                                  });
                                  userProvider.getUserData();
                                }
                              },
                              child: Image.asset(
                                'assets/google.png',
                                fit: BoxFit.fitHeight,
                                height: Responsive.getHeightFromPrecentage(
                                    context,
                                    Responsive.isDesktop(context) ? 10 : 10),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'atau login menggunakan : ',
                            style: TextStyle(
                                color: Colors.blueGrey.shade800, fontSize: 12),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                              onTap: () {
                                if (!onSync) {
                                  setState(() {
                                    isLoginWithEmailPassword = true;
                                  });
                                }
                              },
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    color: Colors.blue.shade400, fontSize: 12),
                              ))
                        ],
                      ),
              ),
            ),
          )
        : FlutterLogin(
            title: 'WAREGRAPH',
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
                fillColor:
                    const Color.fromARGB(255, 51, 41, 124).withOpacity(.1),
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
