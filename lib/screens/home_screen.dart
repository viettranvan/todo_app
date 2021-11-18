import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todolist_cubit.dart';
import 'package:todo_app/cubit/todolist_state.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/screens.dart';
import 'package:todo_app/services/fake_data.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/todo_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodolistCubit>(context).loadTodo(LIST_TODOS);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(
              color: Color(0xff162133),
              fontWeight: FontWeight.w500,
              fontSize: 18.0),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Align(
        alignment: Alignment(1.0, 0.8),
        child: FloatingActionButton(
          onPressed: () => context.read<TodolistCubit>().addTodo(
                Todo(
                    id: 1,
                    color: Colors.greenAccent,
                    title: "New Notes",
                    content: "content"),
              ),
          child: Icon(Icons.add),
          backgroundColor: Color(0xff333333),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TodolistCubit,TodolistState>(
          builder: (context, state){
            if(state is! TodoLoad) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final todos = state.todos;
            return Column(
              children: [
                const SizedBox(height: 20.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xff333333),
                        ),
                        hintText: "Search your Notes",
                        hintStyle: TextStyle(color: Color(0xffd9d9d9)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(width: 1.0))),
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  TodoDetailScreen(todo: todos[index])));
                        },
                        child: TodoCard(
                          color: todos[index].color,
                          title: todos[index].title,
                          content: todos[index].content,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: Color(0xffffffff),
                  height: 50.0,
                  child: Center(
                    child:
                    Text("${todos.length} Notes", style: kTextW400Size14),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
