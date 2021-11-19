import 'package:bloc/bloc.dart';
import 'package:todo_app/cubit/todo_detail_state.dart';
import 'package:todo_app/cubit/todolist_cubit.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoDetailCubit extends Cubit<TodoDetailState>{
  final TodolistCubit _todoCubit;
  TodoDetailCubit(this._todoCubit) : super(Initial());

  void deleteTodo(Todo todo){
    _todoCubit.deleteTodo(todo);
    emit(Delete());
  }

  void editTodo(){
    emit(Edit());
  }

  void saveTodo(Todo todo, Todo update){

    todo.content =  update.content;
    todo.title = update.title;

    _todoCubit.updateTodo();

    emit(Save());
  }

}