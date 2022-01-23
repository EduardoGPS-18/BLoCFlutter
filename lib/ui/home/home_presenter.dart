import 'package:bloc_test/presentation/home/home.dart';

abstract class HomePresenter {
  Stream<HomeState> get homeStateStream;
  HomeState get currentHomeState;

  void emmitEvent<E extends HomeEvent>(E event);
}
