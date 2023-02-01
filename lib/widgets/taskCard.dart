import 'package:flutter/material.dart';
import 'package:todolist/services/requests.dart';
import 'package:todolist/style/Colors.dart';

class TaskCard extends StatefulWidget {
  TaskCard(
      {super.key,
      this.id,
      this.title,
      this.dueDate,
      this.isCompleted,
      this.comments,
      this.description,
      this.tags});

  int? id;
  String? title;
  int? isCompleted;
  String? dueDate;
  String? comments;
  String? description;
  String? tags;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool? isChecked;

  @override
  Widget build(BuildContext context) {
    setState(() {
      isChecked = chanceValue(widget.isCompleted);
    });

    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 1,
          color: ColorStyle.borderCard,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: widget.isCompleted == 0 ? ColorStyle.linear2 : ColorStyle.linear1,
      elevation: 10,
      shadowColor: ColorStyle.linear1,
      child: ListTile(
        leading: Checkbox(
          onChanged: (bool? value) {
            setState(() {
              isChecked = value;
              if (isChecked == true) {
                widget.isCompleted = 1;
              } else {
                widget.isCompleted = 0;
              }
            });
            //We have to update in the database
            ServicesRequest.updateTask(
                id: widget.id.toString(),
                tittle: widget.title,
                comments: widget.comments ?? '',
                description: widget.description ?? '',
                dueDate: widget.dueDate,
                tags: widget.tags ?? '',
                isCompleted: widget.isCompleted.toString());
          },
          value: isChecked,
          shape: const CircleBorder(),
          activeColor: Colors.white,
          checkColor: Colors.black,
        ),
        title: Text(
          widget.title!,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          widget.dueDate == null ? 'Fecha desconocida' : widget.dueDate!,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
            onPressed: () async {
              // When we pressed the deleted button we have to make the request to delete de task
              var res =
                  await ServicesRequest.deleteTask(id: widget.id.toString());
              if (res == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tarea ${widget.title} eliminada')));
                Navigator.pushReplacementNamed(context, 'MainPage');
              }
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            )),
      ),
    );
  }

  bool? chanceValue(int? isCompleted) {
    return isCompleted == 0 ? false : true;
  }
}
