import 'package:bloc/bloc.dart';

mixin BlocPresenter<State, Event> on Bloc<Event, State> {
  Stream<State> get homeStateStream => stream;

  State get currentHomeState => state;
  void emmitEvent<E extends Event>(E event) {
    add(event);
  }
}
