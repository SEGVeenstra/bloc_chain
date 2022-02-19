import 'package:bloc_chain/bloc_chain.dart';

import 'todo.dart';

abstract class TodoEvent extends GlobalEvent {
  const TodoEvent();
}

// User events
class CreateTodo extends TodoEvent {
  final String title;

  const CreateTodo({required this.title});
}

class RemoveTodo extends TodoEvent {
  final int id;

  const RemoveTodo({required this.id});
}

class CheckTodo extends TodoEvent {
  final Todo todo;

  const CheckTodo({required this.todo});
}

class UncheckTodo extends TodoEvent {
  final Todo todo;

  const UncheckTodo({required this.todo});
}

// Database events
abstract class TodoUpdate extends TodoEvent {
  Todo get todo;

  const TodoUpdate();
}

class TodoCreated extends TodoUpdate {
  @override
  final Todo todo;

  const TodoCreated({required this.todo});
}

class TodoRemoved extends TodoUpdate {
  @override
  final Todo todo;

  const TodoRemoved({required this.todo});
}

class TodoUpdated extends TodoUpdate {
  @override
  final Todo todo;

  const TodoUpdated({required this.todo});
}
