class Todo {
  final int id;
  final String title;
  final bool isDone;

  const Todo({
    required this.id,
    required this.title,
    required this.isDone,
  });

  Todo.create({
    required this.title,
    required this.isDone,
  }) : id = DateTime.now().millisecondsSinceEpoch;
}
