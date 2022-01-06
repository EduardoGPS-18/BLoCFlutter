import '../home.dart';

abstract class HomePresenter {
  Stream<HomeState> get homeStateStream;
  HomeState get currentHomeState;

  void emmitEvent<E extends HomeEvent>(E event);
}
