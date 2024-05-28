import 'package:flutter/material.dart';

class NoteAddEditDialog extends StatefulWidget {
  final String? initialTitle;
  final String? initialContent;
  final bool isEditing;

  const NoteAddEditDialog({
    Key? key,
    this.initialTitle,
    this.initialContent,
    required this.isEditing,
  }) : super(key: key);

  @override
  _NoteAddEditDialogState createState() => _NoteAddEditDialogState();
}

class _NoteAddEditDialogState extends State<NoteAddEditDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _titleController.text = widget.initialTitle ?? '';
      _contentController.text = widget.initialContent ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(widget.isEditing ? 'Eslatmani tahrirlash' : 'Eslatma qo\'shish'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Sarlavha'),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(labelText: 'Kontent'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Bekor qilish'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop({
              'title': _titleController.text,
              'content': _contentController.text,
            });
          },
          child: const Text('Saqlash'),
        ),
      ],
    );
  }
}
