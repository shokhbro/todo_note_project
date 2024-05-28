import 'package:todo_note_project/models/todo.dart';

class TodoController {
  final List<Todo> _todo = [];

  List<Todo> get list => _todo;

  void addTodo(int id, String title, String description) {
    _todo.add(Todo(
      id: id,
      title: title,
      description: description,
      date: DateTime.now(),
    ));
  }

  void editTodo(int index, String title, String description) {
    _todo[index].title = title;
    _todo[index].description = description;
  }

  void isCompleted(int index) {
    _todo[index].isCompleted = true;
  }

  void removeTodo(int index) {
    _todo.removeAt(index);
  }
}
