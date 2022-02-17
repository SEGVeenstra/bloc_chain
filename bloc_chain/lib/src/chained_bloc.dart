import 'package:bloc/bloc.dart';
import 'package:bloc_chain/src/global_event.dart';

/// A special [Bloc] that will receive [GlobalEvents].
///
/// A [ChainedBloc] will receive [GlobalEvent]s that have been added
/// with `BlocChain.add(GlobalEvent)`.
class ChainedBloc<State> extends Bloc<GlobalEvent, State> {
  ChainedBloc(initialState) : super(initialState) {
    BlocChain.instance._addBloc(this);
  }

  @override
  Future<void> close() {
    BlocChain.instance._removeBloc(this);
    return super.close();
  }

  void _add(GlobalEvent event) {
    super.add(event);
  }

  /// Old method for adding events to a [Bloc].
  ///
  /// You should be using `BlocChain.instance.add(GlobalEvent)` instead.
  @override
  void add(GlobalEvent event) {
    assert(false, "Use `BlocChain.instance.add(GlobalEvent)` instead!");
  }
}

class BlocChain {
  static BlocChain? _blocChainInstance;

  final List<ChainedBloc> _blocs = [];

  BlocChain._();

  /// Get the instance of the [BlocChain].
  ///
  /// The [BlocChain] is a singleton object.
  static BlocChain get instance => _blocChainInstance ??= BlocChain._();

  void _addBloc(ChainedBloc bloc) {
    _blocs.add(bloc);
  }

  void _removeBloc(ChainedBloc bloc) {
    _blocs.remove(bloc);
  }

  /// Add a [GlobalEvent] that will be passed on to all the [ChainedBloc]s.
  void add(GlobalEvent event) {
    for (var bloc in _blocs) {
      try {
        bloc._add(event);
      } catch (e, _) {
        // Silence the error thrown by `Bloc` when a handler has not been registered.
      }
    }
  }
}
