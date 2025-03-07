import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../api/api_service.dart';



abstract class TodoApiState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoApiInitial extends TodoApiState {}

class TodoApiLoading extends TodoApiState {}

class TodoApiLoaded extends TodoApiState {
  final List<dynamic> todos;

  TodoApiLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodoApiError extends TodoApiState {
  final String message;

  TodoApiError(this.message);

  @override
  List<Object> get props => [message];
}


class TodoApiCubit extends Cubit<TodoApiState> {
  final ApiService _apiService = ApiService();
  
  TodoApiCubit() : super(TodoApiInitial());

  void fetchTodos() async {
    try {
      emit(TodoApiLoading());
      final todos = await _apiService.fetchTodos();
      emit(TodoApiLoaded(todos));
    } catch (e) {
      emit(TodoApiError(e.toString()));
    }
  }
}