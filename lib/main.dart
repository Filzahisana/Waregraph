import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waregraph/services/api/firebase/config.dart';
import 'package:waregraph/services/auth/wrapper.dart';
import 'package:waregraph/services/data/provider/input_provider.dart';
import 'package:waregraph/services/data/provider/user_provider.dart';
import 'package:waregraph/view/layout/layout.dart';
import 'package:waregraph/view/pages/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(Waregraph());
}

class Waregraph extends StatelessWidget {
  const Waregraph({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => InputDataProvider()),
      ],
      child: MaterialApp(
        title: "Waregraph",
        home: AuthWrapper(),
      ),
    );
  }
}
