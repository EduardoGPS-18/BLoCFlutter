import 'package:bloc_test/home/home.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: ElevatedButton(
            child: const Text('Ir para Home!'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HomePage(
                    presenter: HomeBloc(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
