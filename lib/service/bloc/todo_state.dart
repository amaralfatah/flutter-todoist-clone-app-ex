part of 'todo_bloc.dart';

/// Status untuk mengetahui keadaan todo
enum TodoStatus {
  initial, // Keadaan awal
  loading, // Sedang memuat data
  success, // Berhasil memuat/mengubah data
  error, // Terjadi kesalahan
  empty, // Data kosong
}

@immutable
class TodoState {
  final TodoStatus status;
  final List<Todo> todos;
  final String? errorMessage;

  const TodoState({
    this.status = TodoStatus.initial,
    this.todos = const <Todo>[],
    this.errorMessage,
  });

  /// Membuat salinan state dengan nilai baru
  TodoState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
    String? errorMessage,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
