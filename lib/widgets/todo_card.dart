import 'package:flutter/material.dart';
import 'package:todo_app/utils/constants.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({
    required this.color,
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  final Color color;
  final String title;
  final String content;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          height: 150.0,
          width: double.infinity,
          decoration: BoxDecoration(
              color: widget.color, borderRadius: BorderRadius.circular(5.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(31.37, 19.5, 46.01, 12),
                child: Text(
                  widget.title,
                  style: kTextW700Size18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(31.37, 0, 46.01, 7.5),
                child: Text(
                  widget.content,
                  style: kTextW400Size14,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
