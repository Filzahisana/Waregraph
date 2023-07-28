import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waregraph/services/auth/auth.dart';
import 'package:waregraph/services/data/models/user.dart';
import 'package:waregraph/services/data/provider/user_provider.dart';
import 'package:waregraph/view/layout/layout.dart';
import 'package:waregraph/view/layout/size.dart';
import 'package:waregraph/view/pages/login/login.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // final userProvider = context.watch<UserProvider>();
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) => StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            print('Logged in : ' + snapshot.hasData.toString());
            // print('screen is ' + userProvider.screenBody.toString());
            // print('user data status is ' + userProvider.isExists.toString());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Splash();
            }

            if (!snapshot.hasData) {
              userProvider.anonymouslyLogin();
              return const Splash();
            }

            if (snapshot.hasData) {
              return const MainWaregraphLayout();
            }

            // if (snapshot.hasData && userProvider.isExists == null) {
            //   userProvider.processUser();
            // }

            // if (snapshot.hasData &&
            //     userProvider.isExists == true &&
            //     userProvider.userData!.isActive) {
            //   return const MainWaregraphLayout();
            // }

            return Splash();
          }),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context, listen: true);
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) => userProvider.isExists != null &&
              userProvider.userData!.isActive == true
          ? const MainWaregraphLayout()
          : Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox(
                width: Responsive.getWidthFromPrecentage(context, 100),
                height: Responsive.getHeightFromPrecentage(context, 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.purple.shade800,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Mohon Tunggu Sebentar',
                      style: TextStyle(color: Colors.blueGrey.shade800),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
