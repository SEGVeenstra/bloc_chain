import 'package:bloc/bloc.dart';
import 'package:bloc_chain/src/global_event.dart';

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
  static void add(GlobalEvent event) => ChainedBloc._emitGlobal(event);
}
