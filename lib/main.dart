import 'package:flutter/material.dart';
import 'package:todo_assignment/ui/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/' :(context) => SplashScreen(),
      },
    );
  }
}

