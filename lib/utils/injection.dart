import 'package:get_it/get_it.dart';
import 'package:todo_app/cubit/todo_detail_cubit.dart';
import 'package:todo_app/cubit/todolist_cubit.dart';


// su dung getIt
// singleton => tao ta mot instance duy nhat ke tu khi app khoi dong
// bat ky cho nao dung den thi chi tra ve instance da tao trc do
final getIt=GetIt.instance;
Future<void> configureDependencies() async {
  getIt.registerSingleton(TodolistCubit());
  getIt.registerSingleton(TodoDetailCubit(getIt<TodolistCubit>()));
}
