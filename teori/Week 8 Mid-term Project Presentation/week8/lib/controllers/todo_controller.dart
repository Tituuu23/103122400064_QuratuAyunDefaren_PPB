import '../models/todo_model.dart';
import '../services/todo_service.dart';

class TodoController {
  final TodoApiService _service;

  TodoController(this._service);

  List<TodoModel> todos = [];
  bool isLoading = false;
  String? errorMessage;

  void _setLoading(bool value) {
    isLoading = value;
  }

  void _setError(String? message) {
    errorMessage = message;
  }

  Future<void> loadTodos() async {
    _setLoading(true);
    _setError(null);
    try {
      final result = await _service.fetchTodos();
      todos = result;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addTodo(String name, String description) async {
    _setLoading(true);
    _setError(null);
    try {
      final newTodo = await _service.addTodo(
        name: name,
        description: description,
      );
      todos.add(newTodo);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> toggleTodoDone(TodoModel todo) async {
    _setLoading(true);
    _setError(null);
    try {
      final updated = await _service.toggleTodo(todo.id, !todo.isDone);
      final index = todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        todos[index] = updated;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteTodo(TodoModel todo) async {
    _setLoading(true);
    _setError(null);
    try {
      await _service.deleteTodo(todo.id);
      todos.removeWhere((t) => t.id == todo.id);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}