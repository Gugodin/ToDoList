import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/modalWindowController.dart';
import 'package:todolist/services/requests.dart';
import 'package:todolist/style/Colors.dart';
import 'package:todolist/widgets/textFieldModal.dart';

class ButtonAddTaks extends StatelessWidget {
  const ButtonAddTaks({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingActionButton(
      onPressed: (() => openModalWindow(context, size)),
      backgroundColor: Colors.black,
      child: const Icon(Icons.add),
    );
  }

  openModalWindow(context, Size size) async {
    ModalWindowController modalWindowController =
        Get.put(ModalWindowController());

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState2) {
          return AlertDialog(
            backgroundColor: ColorStyle.linear1,
            title: const Center(
              child: Text(
                '¿Que te recordaré?',
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
                    ),
                    TextFieldModal(
                      title: 'Fecha de la tarea(Opcional)',
                      subtitle: '2023-01-25',
                      valueChange: modalWindowController.dueDate,
                      isDate: true,
                    ),
                    TextFieldModal(
                      title: 'Comentario de la tarea(Opcional)',
                      subtitle: 'Escribe un comentario para la tarea',
                      valueChange: modalWindowController.comments,
                    ),
                    TextFieldModal(
                      title: 'Descripcion de la tarea(Opcional)',
                      subtitle: 'Escribe la descripcion de tu tarea',
                      valueChange: modalWindowController.description,
                    ),
                    TextFieldModal(
                      title: 'Tags de la tarea(Opcional)',
                      subtitle: 'Escribe los tasgs de tu tarea',
                      valueChange: modalWindowController.tags,
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
                        // Send request with the payload
                        await ServicesRequest.addNewTask(
                            tittle: modalWindowController.tittleTask.value,
                            dueDate: modalWindowController.dueDate.value,
                            comments: modalWindowController.comments.value,
                            description:
                                modalWindowController.description.value,
                            tags: modalWindowController.tags.value);

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Tarea creada')));
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'MainPage', (route) => false);
                      }
                    },
                    child: const Text('Crear tarea')),
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
