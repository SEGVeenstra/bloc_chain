import 'package:bloc_chain/bloc_chain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_chain/todo/todo_events.dart';

import 'todo.dart';
import 'todo_bloc.dart';

class TodoPage extends StatelessWidget {
  final _textEditController = TextEditingController();

  TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo\'s'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<TodoBloc, List<Todo>>(
              builder: (context, state) => TodoList(todos: state),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textEditController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        BlocChain.instance
                            .add(CreateTodo(title: _textEditController.text));
                        _textEditController.clear();
                      },
                    ),
                    border: const OutlineInputBorder()),
              ),
            ),
          ),
        ],
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
              key: ValueKey(todo.id),
              value: todo.isDone,
              title: Text(todo.title),
              onChanged: (value) {
                if (value) {
                  BlocChain.instance.add(CheckTodo(todo: todo));
                } else {
                  BlocChain.instance.add(UncheckTodo(todo: todo));
                }
              },
            ),
          );
        },
      );
}
