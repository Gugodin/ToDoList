import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/services/requests.dart';
import 'package:todolist/style/Colors.dart';
import 'package:todolist/widgets/textFieldModal.dart';

import '../Models/Task.dart';
import '../controller/modalWindowController.dart';

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
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 1,
          color: ColorStyle.borderCard,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      // Here we change colors when the taks is done or not
      color: widget.isCompleted == 0 ? ColorStyle.linear2 : ColorStyle.linear1,
      elevation: 10,
      shadowColor: ColorStyle.linear1,
      child: ListTile(
        leading: Checkbox(
          onChanged: (bool? value) {
            setState(() {
              isChecked = value;
              if (isChecked == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  '🎉🎉 Felicidades terminaste la tarea ${widget.title} 🎉🎉',
                  textAlign: TextAlign.center,
                )));
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
          // The condition is just in the case that the date is going null
          widget.dueDate == null ? 'Fecha desconocida' : widget.dueDate!,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
            onPressed: () async {
              // When we pressed the deleted button we have to make the request to delete de task
              var res =
                  await ServicesRequest.deleteTask(id: widget.id.toString());
              if (res == true) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tarea ${widget.title} eliminada')));
                Navigator.pushReplacementNamed(context, 'MainPage');
              }
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            )),
            // We call the method of the Modal Window if the card is touched
        onTap: (() => openModalWindow(context, size, widget.id.toString())),
      ),
    );
  }
  // This method just help changin values between the variables isCompleted and isChecked
  // Because of the type of these two isCompleted -> int  isChecked -> bool 
  bool? chanceValue(int? isCompleted) {
    return isCompleted == 0 ? false : true;
  }

  openModalWindow(BuildContext context, size, String id) async {
    Task taskDescriptor = await ServicesRequest.getTaskById(id: id);

    ModalWindowController modalWindowController =
        Get.put(ModalWindowController());

    // Assign the values to the controller because these are the values that we are gonna send to the API
    // The user will have the possiblities to chance these values by the Textfields
    modalWindowController.tittleTask.value = taskDescriptor.title!;
    modalWindowController.dueDate.value = taskDescriptor.dueDate!;
    modalWindowController.description.value = taskDescriptor.description!;
    modalWindowController.comments.value = taskDescriptor.comments!;
    modalWindowController.tags.value = taskDescriptor.tags!;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState2) {
          return AlertDialog(
            backgroundColor: ColorStyle.linear1,
            title: const Center(
              child: Text(
                'Desglose de la tarea',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 3),
              ),
            ),
            content: SizedBox(
              height: size.height * 0.43,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFieldModal(
                      title: 'Titulo de tarea',
                      subtitle: 'Escribe el titulo de tu tarea',
                      valueChange: modalWindowController.tittleTask,
                      insideValue: taskDescriptor.title,
                    ),
                    TextFieldModal(
                      title: 'Fecha de la tarea(Opcional)',
                      subtitle: '2023-01-25',
                      valueChange: modalWindowController.dueDate,
                      isDate: true,
                      insideValue: taskDescriptor.dueDate,
                    ),
                    TextFieldModal(
                      title: 'Comentario de la tarea(Opcional)',
                      subtitle: 'Escribe un comentario para la tarea',
                      valueChange: modalWindowController.comments,
                      insideValue: taskDescriptor.comments,
                    ),
                    TextFieldModal(
                      title: 'Descripcion de la tarea(Opcional)',
                      subtitle: 'Escribe la descripcion de tu tarea',
                      valueChange: modalWindowController.description,
                      insideValue: taskDescriptor.description,
                    ),
                    TextFieldModal(
                      title: 'Tags de la tarea(Opcional)',
                      subtitle: 'Escribe los tasgs de tu tarea',
                      valueChange: modalWindowController.tags,
                      insideValue: taskDescriptor.tags,
                    ),
                    Builder(
                      builder: (context) {
                        return modalWindowController.hasError.value == true
                            ? Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      'Escribe un titulo por favor',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            : Text('');
                      },
                    )
                  ],
                ),
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        side: const BorderSide(color: Colors.white, width: 1)),
                    onPressed: () async {
                      if (modalWindowController.tittleTask.value == '') {
                        modalWindowController.hasError.value = true;
                        setState2(
                          () {},
                        );
                      } else {
                        // Send request with payload
                        await ServicesRequest.updateTask(
                            id: widget.id.toString(),
                            isCompleted: widget.isCompleted.toString(),
                            tittle: modalWindowController.tittleTask.value,
                            dueDate: modalWindowController.dueDate.value,
                            comments: modalWindowController.comments.value,
                            description:
                                modalWindowController.description.value,
                            tags: modalWindowController.tags.value);


                        // ignore: use_build_context_synchronously
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'MainPage', (route) => false);
                      }
                    },
                    child: const Text('Actualizar tarea')),
              )
            ],
          );
        },
      ),
    );

    // every time that we close de modal window we reset the values of the textfields
    modalWindowController.tittleTask.value = '';
    modalWindowController.dueDate.value = '';
    modalWindowController.comments.value = '';
    modalWindowController.description.value = '';
    modalWindowController.tags.value = '';
    modalWindowController.hasError.value = false;
  }
}
