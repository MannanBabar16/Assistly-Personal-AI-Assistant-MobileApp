import 'package:assistly/Pages/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Assistly',
      theme: ThemeData(
       
        colorScheme: ColorScheme.light(
          primary: Colors.black,
        ),


        textTheme: GoogleFonts.poppinsTextTheme(),


      ),
      home: LoginPage(),

    );
  }
}



