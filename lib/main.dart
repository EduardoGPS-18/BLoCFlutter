import 'package:bloc_test/data/usecases/remote_login.dart';
import 'package:bloc_test/presentation/home/home.dart';
import 'package:flutter/material.dart';

import 'main/builders/builders.dart';
import 'main/composites/composites.dart';
import 'ui/home/home.dart';
import 'ui/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightThemeData,
      home: HomePage(
        presenter: HomeBloc(
          loginUseCase: RemoteLogin(),
          validation: ValidationComposite(
            [
              ...ValidationBuilder.field('email').required().email().build(),
              ...ValidationBuilder.field('password').required().min(6).build(),
            ],
          ),
        ),
      ),
    );
  }
}
