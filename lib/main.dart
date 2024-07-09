import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'BasicsLearning/CloudFirestore/cloud_firestore.dart';
import 'BasicsLearning/PhoneAuth/phoneauth.dart';
import 'BasicsLearning/Storage/signup_storage.dart';
import 'BasicsLearning/demo/Pages/databse_options.dart';
import 'BasicsLearning/demo/Pages/login_signup.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.purple,
      ),
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return const DatabseOptions();
      //     } else {
      //       return const LoginSignPage();
      //     }
      //   },
      // ),
      // home: const Phoneauth(),
      home: const SignupStorage(),
      // home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      //   if(snapshot.hasData){
      //     return const CloudFirestore();
      //   }else{
      //     return const SignupStorage();
      //   }
      // },),
      // home: const CloudFirestore(),
    );
  }
}
