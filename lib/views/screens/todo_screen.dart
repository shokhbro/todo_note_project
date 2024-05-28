import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_note_project/controllers/todo_controller.dart';
import 'package:todo_note_project/views/screens/note_screen.dart';
import 'package:todo_note_project/views/widgets/add_edit_todo_widget.dart';
import 'package:todo_note_project/views/widgets/task_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoController todoController = TodoController();

  void _addTask() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return const TodoAddEditDialog(
          isEditing: false,
        );
      },
    );

    if (result != null) {
      setState(() {
        todoController.addTodo(
          id(todoController.list.length + 1),
          result['title']!,
          result['description']!,
        );
      });
    }
  }

  void _editTask(int index) async {
    final initialTitle = todoController.list[index].title;
    final initialDescription = todoController.list[index].description;

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return TodoAddEditDialog(
          initialTitle: initialTitle,
          initialDescription: initialDescription,
          isEditing: true,
        );
      },
    );

    if (result != null) {
      setState(() {
        todoController.editTodo(
          index,
          result['title']!,
          result['description']!,
        );
      });
    }
  }

  int id(int index) {
    return index++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "Rejalar Bo'limi",
          style: TextStyle(
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((ctx) => const NoteScreen()),
                ),
              );
            },
            child: const Row(
              children: [
                Text("Eslatma..."),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Gap(10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const Gap(230),
                InkWell(
                  onTap: () => _addTask(),
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber,
                    ),
                    child: const Center(
                      child: Text(
                        "Reja qo'shish",
                        style: TextStyle(
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoController.list.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  task: todoController.list[index],
                  onDelete: () {
                    setState(() {
                      todoController.removeTodo(index);
                    });
                  },
                  onEdit: () => _editTask(index),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
