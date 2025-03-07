import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/todo_api_cubit.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: BlocBuilder<TodoApiCubit, TodoApiState>(
        builder: (context, state) {
          if (state is TodoApiLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoApiLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo['title']),
                  leading: Icon(
                    todo['completed'] ? Icons.check_circle : Icons.circle_outlined,
                    color: todo['completed'] ? Colors.green : Colors.grey,
                  ),
                );
              },
            );
          } else if (state is TodoApiError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Press button to load todos'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<TodoApiCubit>().fetchTodos(),
        child: const Icon(Icons.download),
      ),
    );
  }
}
