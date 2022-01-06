import 'package:flutter/material.dart';

import 'home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          filled: true,
          hoverColor: Colors.pink,
          errorStyle: TextStyle(color: Colors.pink),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(24)),
            gapPadding: 12,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(24)),
            gapPadding: 12,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(24)),
            gapPadding: 12,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ),
      ),
      home: HomePage(
        presenter: HomeBloc(),
      ),
    );
  }
}
