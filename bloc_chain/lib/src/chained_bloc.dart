import 'package:bloc/bloc.dart';
import 'package:bloc_chain/src/global_event.dart';

/// A special [Bloc] that will receive [GlobalEvents].
///
/// A [ChainedBloc] will receive [GlobalEvent]s that have been added
/// with `BlocChain.add(GlobalEvent)`.
class ChainedBloc<State> extends Bloc<GlobalEvent, State> {
  static final List<ChainedBloc> _blocs = [];

  ChainedBloc(initialState) : super(initialState) {
    _blocs.add(this);
  }

  @override
  Future<void> close() {
    _blocs.remove(this);
    return super.close();
  }

  void _add(GlobalEvent event) {
    super.add(event);
  }

  static void _emitGlobal(GlobalEvent event) {
    for (var bloc in _blocs) {
      try {
        bloc._add(event);
      } catch (e, _) {
        print(e);
      }
    }
  }

  @override
  void add(GlobalEvent event) {
    assert(false, "Use `BlocChain.add(GlobalEvent)` instead!");
  }
}

class BlocChain {
  BlocChain._();

  /// Add a [GlobalEvent] that will be passed on to all the [ChainedBloc]s.
  static void add(GlobalEvent event) => ChainedBloc._emitGlobal(event);
}
