import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/Models/Task.dart';
import 'package:todolist/controller/modalWindowController.dart';
import 'package:todolist/services/requests.dart';
import 'package:todolist/style/Colors.dart';
import 'package:todolist/widgets/appBarScaffold.dart';
import 'package:todolist/widgets/titleScaffold.dart';

import '../widgets/buttonAdd.dart';
import '../widgets/taskCard.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return SafeArea(
      child: Scaffold(
        appBar: const AppBarScaffold(),
        body: Container(
          width: size.width,
          height: size.height,
          color: ColorStyle.backGroundColorBody,
          child: FutureBuilder(
            future: ServicesRequest.getAllTask(),
            builder: (context, snapshot) {
              // We call the request to get all the task from the token "javier"
              if (snapshot.hasData) {
                return generateListView(snapshot.data);
              }
              // If we dont have data a circle preogres indicator appears
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            },
          ),
        ),
        floatingActionButton: const ButtonAddTaks(),
      ),
    );
  }

  Widget generateListView(List<Task>? data) {
    // Generating all the task that we get in the request
    return ListView.builder(
      itemCount: data?.length,
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      itemBuilder: (context, index) {
        return TaskCard(
          id: data?[index].id,
          title: data?[index].title,
          dueDate: data?[index].dueDate,
          isCompleted: data?[index].isCompleted,
          comments: data?[index].comments,
          description: data?[index].description,
          tags: data?[index].tags,
        );
      },
    );
  }
}
