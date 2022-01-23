import 'package:bloc_test/data/usecases/remote_login.dart';
import 'package:bloc_test/main/builders/builders.dart';
import 'package:bloc_test/main/composites/composites.dart';
import 'package:bloc_test/presentation/home/home.dart';
import 'package:bloc_test/ui/ui.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Ir para Home!'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => HomePage(
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
              ),
            );
          },
        ),
      ),
    );
  }
}
