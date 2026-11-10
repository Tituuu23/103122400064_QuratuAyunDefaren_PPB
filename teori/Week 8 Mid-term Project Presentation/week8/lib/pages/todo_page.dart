import 'package:flutter/material.dart';
import '../controllers/todo_controller.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late final TodoController _controller;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TodoController(TodoApiService());
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await _controller.loadTodos();
    setState(() {});
  }

  Future<void> _onRefresh() async {
    await _controller.loadTodos();
    setState(() {});
  }

  Future<void> _onAddTodo(String name, String description) async {
    await _controller.addTodo(name, description);
    setState(() {});
  }

  Future<void> _onToggle(TodoModel todo) async {
    await _controller.toggleTodoDone(todo);
    setState(() {});
  }

  Future<void> _onDelete(TodoModel todo) async {
    await _controller.deleteTodo(todo);
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _showAddTodoDialog() async {
    _nameController.clear();
    _descriptionController.clear();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final name = _nameController.text.trim();
                final description = _descriptionController.text.trim();
                if (name.isEmpty || description.isEmpty) {
                  return;
                }
                await _onAddTodo(name, description);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showItemOptionsDialog(TodoModel todo) async {
    final isCurrentlyDone = todo.isDone;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Todo Options'),
          content: Text('Choose an action for the todo:\n"${todo.name}"'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _onToggle(todo);
              },
              child: Text(
                isCurrentlyDone ? 'Mark as not done' : 'Mark as done',
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _onDelete(todo);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todos = _controller.todos;
    final isLoading = _controller.isLoading;
    final errorMessage = _controller.errorMessage;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todos API Supabase'),
      ),
      body: Column(
        children: [
          if (isLoading) const LinearProgressIndicator(),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: todos.isEmpty && !isLoading
                  ? const Center(
                      child: Text('Todo not found. Add your first todo!'),
                    )
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        final textStyle = TextStyle(
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        );

                        return ListTile(
                          leading: Icon(
                            todo.isDone
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                          ),
                          title: Text(
                            todo.name,
                            style: textStyle,
                          ),
                          subtitle: Text(
                            todo.description,
                            style: textStyle,
                          ),
                          onLongPress: () => _showItemOptionsDialog(todo),
                          onTap: () => _showItemOptionsDialog(todo),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : _showAddTodoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}