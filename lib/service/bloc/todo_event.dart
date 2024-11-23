part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

/// Event untuk inisialisasi todo
class TodoInitEvent extends TodoEvent {}

/// Event untuk menambah todo baru
class TodoAddEvent extends TodoEvent {
  final String title;
  final String description;

  TodoAddEvent({
    required this.title,
    required this.description,
  });
}

/// Event untuk mengedit todo
class TodoEditEvent extends TodoEvent {
  final String id;
  final String title;
  final String description;

  TodoEditEvent({
    required this.id,
    required this.title,
    required this.description,
  });
}

/// Event untuk menghapus todo
class TodoDeleteEvent extends TodoEvent {
  final String id;

  TodoDeleteEvent({required this.id});
}
