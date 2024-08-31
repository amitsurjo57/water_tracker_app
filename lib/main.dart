import 'package:flutter/material.dart';
import 'package:water_tracker_app/home_screen.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0A80F6),
      ),
      home: const HomeScreen(),
    );
  }
}
