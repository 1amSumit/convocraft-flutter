import 'package:convocraft/firebase_options.dart';
import 'package:convocraft/screens/All_user_screen.dart';
import 'package:convocraft/screens/getting_started.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ConvoCraft",
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitSpinningLines(
              color: Colors.black,
            );
          }
          if (snapshot.hasData) {
            return const AllUserScreen();
          }

          return const GettingStartedScreen();
        },
      ),
    );
  }
}
