import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_assignment/ui/PersonalListing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersonalListing(),
    );
  }
}

