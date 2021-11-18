import 'package:bloc/bloc.dart';
import 'package:todo_app/cubit/todolist_state.dart';
import 'package:todo_app/models/todo_model.dart';


class TodolistCubit extends Cubit<TodolistState>{
  TodolistCubit() : super(TodoInitial());


  loadTodo(List<Todo> todos) {
    emit(TodoLoad(todos));
  }

  addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodoLoad) {
      currentState.todos.add(todo);
      emit(TodoLoad(currentState.todos));
    }
  }


}



