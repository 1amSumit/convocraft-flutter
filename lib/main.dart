// import 'package:convocraft/firebase_options.dart';
// import 'package:convocraft/screens/All_user_screen.dart';
import 'package:convocraft/screens/getting_started.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ConvoCraft",
      home: GettingStartedScreen(),
    );
  }
}

// home: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (ctx, snapshot) {
//           if (snapshot.hasData) {
//             return AllUserScreen();
//           }
//           return GettingStartedScreen();
//         },
//       ),