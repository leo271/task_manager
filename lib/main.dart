import 'package:flutter/material.dart';
import 'package:task_manager/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(255, 104, 184, 223),
          secondary: Color.fromARGB(221, 92, 92, 92),
          background: Color.fromARGB(31, 18, 18, 18),
          surface: Color.fromARGB(31, 129, 129, 129),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: Colors.white,
          onSurface: Colors.white,
          // 他の色設定
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
