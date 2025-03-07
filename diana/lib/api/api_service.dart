import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

  Future<List<dynamic>> fetchTodos() async {
    final response = await _dio.get('/todos');
    return response.data;
  }
}
