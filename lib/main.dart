import 'package:flutter/material.dart';
import 'data_file.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try{
    await Firebase.initializeApp(
      name: "tick_dex",
      options: const FirebaseOptions(
          apiKey: "AIzaSyAHyCR3BE5rS_zsFU6YsGZCkNJ9FvpvMvA",
          authDomain: "tick-2ff7f.firebaseapp.com",
          databaseURL: "https://tick-2ff7f-default-rtdb.firebaseio.com",
          projectId: "tick-2ff7f",
          storageBucket: "tick-2ff7f.appspot.com",
          messagingSenderId: "211150956458",
          appId: "1:211150956458:web:ef007364b6e7ee28f4add3",
          measurementId: "G-3PQ2N4YP0B"),
    );
  }catch (e) {
    Firebase.app();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      initialRoute: 'first',
      routes: myNavRoutes,
    ); // MaterialApp
  }
} // end of MyApp
