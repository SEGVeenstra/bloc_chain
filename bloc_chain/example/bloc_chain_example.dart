import 'dart:math';

import 'package:bloc_chain/src/chained_bloc.dart';
import 'package:bloc_chain/src/global_event.dart';

// Here we create a new Event.
class RandomEvent extends GlobalEvent {}

// Then we create two (Chained)Blocs.
// One for a random number, and another for a random color.
class RandomNumberBloc extends ChainedBloc<int> {
  RandomNumberBloc() : super(0) {
    // We add the eventHandler for our event.
    on<RandomEvent>((event, emit) => emit(Random().nextInt(10)));
  }
}

class RandomColorBloc extends ChainedBloc<String> {
  static const _colors = [
    'red',
    'blue',
    'orange',
    'yellow',
    'purple',
    'pink',
    'green'
  ];

  RandomColorBloc() : super(_colors[0]) {
    // And for this one as well.
    on<RandomEvent>(
        (event, emit) => emit(_colors[Random().nextInt(_colors.length - 1)]));
  }
}

void main() {
  // Now let's create some instances of each (Chained)Bloc.
  final randomNumberBloc = RandomNumberBloc();
  final randomColorBloc = RandomColorBloc();

  // And ofcourse some listeners so we know what the new states are.
  randomNumberBloc.stream.listen((state) => print(state));
  randomColorBloc.stream.listen((state) => print(state));

  // Finally we add the event a few times.
  BlocChain.add(RandomEvent());
  BlocChain.add(RandomEvent());
  BlocChain.add(RandomEvent());
  BlocChain.add(RandomEvent());
  BlocChain.add(RandomEvent());
}
