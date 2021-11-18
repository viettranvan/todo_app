import 'package:todo_app/models/todo_model.dart';

abstract class TodolistState {}

class TodoInitial extends TodolistState {}

class TodoLoad extends TodolistState {
  final List<Todo> todos;

  TodoLoad(this.todos);

}

