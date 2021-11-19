import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_detail_cubit.dart';
import 'package:todo_app/cubit/todo_detail_state.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/utils/constants.dart';

class TodoDetailScreen extends StatefulWidget {
  const TodoDetailScreen({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.todo.title;
    _contentController.text = widget.todo.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<TodoDetailCubit, TodoDetailState>(
        listener: (context, state) {
          if (state is Delete) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Delete successfully"),
            ));
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<TodoDetailCubit, TodoDetailState>(builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (state is Edit)
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(27.0, 0.0, 24.0, 0.0),
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        controller: _titleController,
                        minLines: 1,
                        maxLines: 1,
                        style: kTextW700Size24,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )
                  : Padding(
                      padding:
                          const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 40.0),
                      child: Text(
                        widget.todo.title,
                        style: kTextW700Size24,
                      ),
                    ),
              Expanded(
                child: (state is Edit)
                    ? Padding(
                        padding:
                            const EdgeInsets.fromLTRB(27.0, 0.0, 24.0, 0.0),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          controller: _contentController,
                          minLines: 1,
                          maxLines: null,
                          style: kTextW400Size18,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(27.0, 0.0, 24.0, 0.0),
                          child:
                              Text(widget.todo.content, style: kTextW400Size18),
                        ),
                      ),
              ),
              Container(
                height: 50.0,
                width: double.infinity,
                color: Color(0xffffffff),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          AlertDialog alert = AlertDialog(
                            title: Text("Warning"),
                            content: Text("Are you sure you want to delete?"),
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  BlocProvider.of<TodoDetailCubit>(context)
                                      .deleteTodo(widget.todo);
                                },
                              ),
                            ],
                          );

                          showDialog(
                              context: context,
                              builder: (BuildContext context) => alert);
                        },
                        child: Icon(Icons.delete, color: Color(0xffE54C38))),
                    GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Color(0xff333333),
                        radius: 18.0,
                        child: Icon(Icons.add),
                      ),
                    ),
                    (state is Edit)
                        ? GestureDetector(
                            onTap: () {
                              final todo = widget.todo;
                              BlocProvider.of<TodoDetailCubit>(context).saveTodo(
                                todo,
                                Todo(
                                    id: todo.id,
                                    content: _contentController.text,
                                    color: todo.color,
                                    title: _titleController.text),
                              );
                            },
                            child: Icon(Icons.check_circle_outline),
                          )
                        : GestureDetector(
                            onTap: () {
                              BlocProvider.of<TodoDetailCubit>(context).editTodo();
                            },
                            child: Icon(Icons.edit),
                          ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
