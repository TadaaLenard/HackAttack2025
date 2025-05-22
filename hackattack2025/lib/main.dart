import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackattack2025/navigation/route.dart';
import 'package:hackattack2025/roleselection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.getRoutes(),
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.aclonicaTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Roleselection(),
    );
  }
}
