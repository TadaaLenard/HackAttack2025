import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackattack2025/navigation/route.dart';

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
        textTheme: GoogleFonts.aclonicaTextTheme()
            .apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            )
            .copyWith(
              bodyMedium: GoogleFonts.aclonica(fontSize: 15),
            ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.roleselection,
    );
  }
}
