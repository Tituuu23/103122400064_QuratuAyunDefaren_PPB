import 'package:dio/dio.dart';
import '../env/env_config.dart';
import '../models/todo_model.dart';

class TodoApiService {
  final String _baseUrl = EnvConfig.supabaseUrl;
  final String _anonKey = EnvConfig.supabaseAnonKey;
  final String _table = EnvConfig.todosTable;

  late final Dio _dio;

  TodoApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
          'apikey': _anonKey,
          'Authorization': 'Bearer $_anonKey',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  /// GET /rest/v1/todos?select=*
  Future<List<TodoModel>> fetchTodos() async {
    try {
      final response = await _dio.get(
        '/rest/v1/$_table',
        queryParameters: {'select': '*'},
      );
      final data = response.data as List<dynamic>;
      return data.map((e) => TodoModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(
        'Dio Error (fetchTodos): ${e.response?.statusCode} ${e.message}',
      );
    } catch (e) {
      throw Exception('Error fetchTodos: $e');
    }
  }

  /// POST /rest/v1/todos
  Future<TodoModel> addTodo({
    required String name,
    required String description,
  }) async {
    try {
      final response = await _dio.post(
        '/rest/v1/$_table',
        data: {
          'name': name,
          'description': description,
          'is_done': false,
        },
        options: Options(
          headers: {'Prefer': 'return=representation'},
        ),
      );
      final list = response.data as List<dynamic>;
      return TodoModel.fromJson(list.first);
    } on DioException catch (e) {
      throw Exception(
        'Dio Error (addTodo): ${e.response?.statusCode} ${e.message}',
      );
    } catch (e) {
      throw Exception('Error addTodo: $e');
    }
  }

  /// PATCH /rest/v1/todos?id=eq.<id>
  Future<TodoModel> toggleTodo(int id, bool isDone) async {
    try {
      final response = await _dio.patch(
        '/rest/v1/$_table',
        queryParameters: {'id': 'eq.$id'},
        data: {
          'is_done': isDone,
        },
        options: Options(
          headers: {'Prefer': 'return=representation'},
        ),
      );
      final list = response.data as List<dynamic>;
      return TodoModel.fromJson(list.first);
    } on DioException catch (e) {
      throw Exception(
        'Dio Error (toggleTodo): ${e.response?.statusCode} ${e.message}',
      );
    } catch (e) {
      throw Exception('Error toggleTodo: $e');
    }
  }

  /// DELETE /rest/v1/todos?id=eq.<id>
  Future<void> deleteTodo(int id) async {
    try {
      final response = await _dio.delete(
        '/rest/v1/$_table',
        queryParameters: {'id': 'eq.$id'},
      );
      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('Supabase Delete Error Code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(
        'Dio Error (deleteTodo): ${e.response?.statusCode} ${e.message}',
      );
    } catch (e) {
      throw Exception('Error deleteTodo: $e');
    }
  }
}