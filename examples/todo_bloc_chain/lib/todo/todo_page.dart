import 'package:bloc_chain/bloc_chain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_chain/todo/todo_events.dart';

import 'todo.dart';
import 'todo_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo\'s'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            BlocChain.instance.add(const CreateTodo(title: 'test2')),
      ),
      body: BlocBuilder<TodoBloc, List<Todo>>(
        builder: (context, state) => TodoList(todos: state),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList({
    required this.todos,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];

          return Dismissible(
            key: ValueKey(todo.id),
            onDismissed: (_) => BlocChain.instance.add(RemoveTodo(id: todo.id)),
            child: SwitchListTile(
              value: todo.isDone,
              title: Text(todo.title),
              onChanged: (_) {},
            ),
          );
        },
      );
}
