import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoist_clone_app/data/todo.dart';
import 'package:todoist_clone_app/service/todo_shared_preferences.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // Menambahkan dokumentasi
  /// Service untuk menyimpan todo ke dalam SharedPreferences
  final TodoSharedPreferences todoSharedPreferences;

  TodoBloc(this.todoSharedPreferences) : super(const TodoState()) {
    on<TodoInitEvent>(_onInitTodo);
    on<TodoAddEvent>(_onAddTodo);
    on<TodoEditEvent>(_onEditTodo);
    on<TodoDeleteEvent>(_onDeleteTodo);
  }

  // Mengubah return type menjadi Future<void> untuk async
  Future<void> _onInitTodo(
    TodoInitEvent event,
    Emitter<TodoState> emit,
  ) async {
    // 1. Update status menjadi loading
    emit(state.copyWith(status: TodoStatus.loading));

    try {
      // 2. Ambil data todos
      final todos = await todoSharedPreferences.getAllTodos();

      // 3. Update state dengan data baru
      emit(state.copyWith(
        status: TodoStatus.success,
        todos: todos,
      ));
    } catch (e) {
      // 4. Handle error
      emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: 'Gagal memuat todo',
      ));
    }
  }

  Future<void> _onAddTodo(
    TodoAddEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      // 1. Buat todo baru
      final newTodo = Todo(
        title: event.title,
        description: event.description,
      );

      // 2. Simpan ke local storage
      await todoSharedPreferences.saveTodo(newTodo);

      // 3. Update state
      final updatedTodos = [...state.todos, newTodo];
      emit(state.copyWith(
        status: TodoStatus.success,
        todos: updatedTodos,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: 'Gagal menambah todo',
      ));
    }
  }

  Future<void> _onEditTodo(
    TodoEditEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      // 1. Buat todo yang sudah diedit
      final editedTodo = Todo(
        id: event.id,
        title: event.title,
        description: event.description,
      );

      // 2. Update di local storage
      await todoSharedPreferences.saveTodo(editedTodo);

      // 3. Update state
      final updatedTodos = state.todos.map((todo) {
        return todo.id == event.id ? editedTodo : todo;
      }).toList();

      emit(state.copyWith(
        status: TodoStatus.success,
        todos: updatedTodos,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: 'Gagal mengedit todo',
      ));
    }
  }

  Future<void> _onDeleteTodo(
    TodoDeleteEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      // 1. Hapus dari local storage
      await todoSharedPreferences.deleteTodoById(event.id);

      // 2. Update state
      final updatedTodos =
          state.todos.where((todo) => todo.id != event.id).toList();
      emit(state.copyWith(
        status: TodoStatus.success,
        todos: updatedTodos,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: 'Gagal menghapus todo',
      ));
    }
  }
}
