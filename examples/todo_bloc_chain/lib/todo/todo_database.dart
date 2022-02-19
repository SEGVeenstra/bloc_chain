import 'package:bloc_chain/bloc_chain.dart';
import 'package:todo_bloc_chain/todo/todo.dart';

import 'todo_events.dart';

class TodoDatabase {
  final _data = <Todo>[];

  List<Todo> getTodos() => _data.toList(growable: false);

  void addTodo(Todo todo) {
    _data.add(todo);
    BlocChain.instance.add(TodoCreated(todo: todo));
  }

  void removeTodo(int id) {
    final todo = _data.firstWhere((todo) => todo.id == id);
    _data.remove(todo);
    BlocChain.instance.add(TodoRemoved(todo: todo));
  }

  void updateTodo(Todo todo) {
    final oldTodo = _data.firstWhere((t) => t.id == todo.id);
    final index = _data.indexOf(oldTodo);
    _data.remove(oldTodo);
    _data.insert(index, todo);
    BlocChain.instance.add(TodoUpdated(todo: todo));
  }
}
