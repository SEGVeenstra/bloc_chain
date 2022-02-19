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
    on<TodoUpdate>(_onTodoUpdated);
    on<CheckTodo>(_onCheckTodo);
    on<UncheckTodo>(_onUncheckTodo);
  }

  void _onCreateTodo(CreateTodo event, Emitter<List<Todo>> emit) =>
      _todoDatabase.addTodo(
        Todo.create(
          title: event.title,
          isDone: false,
        ),
      );

  void _onRemoveTodo(RemoveTodo event, Emitter<List<Todo>> emit) =>
      _todoDatabase.removeTodo(event.id);

  void _onTodoUpdated(TodoUpdate event, Emitter<List<Todo>> emit) {
    final todos = _todoDatabase.getTodos();
    emit.call(todos);
  }

  void _onCheckTodo(CheckTodo event, Emitter<List<Todo>> emit) {
    final todo = Todo(
      id: event.todo.id,
      title: event.todo.title,
      isDone: true,
    );
    _todoDatabase.updateTodo(todo);
  }

  void _onUncheckTodo(UncheckTodo event, Emitter<List<Todo>> emit) {
    final todo = Todo(
      id: event.todo.id,
      title: event.todo.title,
      isDone: false,
    );
    _todoDatabase.updateTodo(todo);
  }
}
