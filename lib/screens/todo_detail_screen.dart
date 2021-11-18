import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todolist_cubit.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/fake_data.dart';
import 'package:todo_app/utils/constants.dart';

class TodoDetailScreen extends StatefulWidget {
  const TodoDetailScreen({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.todo.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 40.0),
            child: Text(
              widget.todo.title,
              style: kTextW700Size24,
            ),
          ),
          Expanded(
            child: isEdit
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(27.0, 0.0, 24.0, 0.0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      controller: _controller,
                      minLines: 1,
                      maxLines: null,
                      style: kTextW400Size18,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(27.0, 0.0, 24.0, 0.0),
                      child: Text(widget.todo.content, style: kTextW400Size18),
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
                              // Navigator.of(context).pop();
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
                GestureDetector(
                    onTap: () => setState(() {
                          isEdit = !isEdit;
                        }),
                    child: isEdit
                        ? Icon(Icons.check_circle_outline)
                        : Icon(Icons.edit)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
