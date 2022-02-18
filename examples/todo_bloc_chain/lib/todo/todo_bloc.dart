import 'package:bloc_chain/bloc_chain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_chain/todo/todo_database.dart';
import 'package:todo_bloc_chain/todo/todo_events.dart';

import 'todo.dart';

class TodoBloc extends ChainedBloc<List<Todo>> {
  final TodoDatabase _todoDatabase;

  TodoBloc(this._todoDatabase) : super(<Todo>[]) {
    on<CreateTodo>(_onCreateTodo);
    on<RemoveTodo>(_onRemoveTodo);
    on<TodoUpdate>(_onBlocCreated);
  }

  void _onCreateTodo(CreateTodo event, Emitter<List<Todo>> emitter) =>
      _todoDatabase.addTodo(
        Todo.create(
          title: event.title,
          isDone: false,
        ),
      );

  void _onRemoveTodo(RemoveTodo event, Emitter<List<Todo>> emitter) =>
      _todoDatabase.removeTodo(event.id);

  void _onBlocCreated(TodoUpdate event, Emitter<List<Todo>> emit) {
    final todos = _todoDatabase.getTodos();
    emit.call(todos);
  }
}
