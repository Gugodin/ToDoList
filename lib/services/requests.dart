import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/Models/Task.dart';

class ServicesRequest {
  static Future<List<Task>> getAllTask() async {
    var headersList = {
      'Authorization':
          'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
      'Content-Type': 'application/json',
    };
    var url =
        Uri.parse('https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks');

    var body = {"token": "javier"};

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    List results = jsonDecode(resBody);

    List<Task> listOfRestults = [];

    for (var element in results) {
      Task task = Task(
          id: element['id'],
          title: element['title'],
          isCompleted: element['is_completed'],
          dueDate: element['due_date']);

      listOfRestults.add(task);
    }

    return listOfRestults;
  }

  static Future<bool> addNewTask(
      {required String tittle,
      String? dueDate,
      String? comments,
      String? description,
      String? tags}) async {
    var headersList = {
      'Authorization':
          'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
    };
    var url =
        Uri.parse('https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks');

    String? date;

    if (dueDate == '') {
      var now = DateTime.now();
      date = now.toString().split(' ')[0];
    } else {
      date = dueDate;
    }

    var body = {
      "token": "javier",
      "title": tittle,
      "is_completed": '0',
      "due_date": date,
      "comments": comments,
      "description": description,
      "tags": tags,
    };

    var req = await http.post(url, body: body, headers: headersList);

    if (req.statusCode == 201) {
      return true;
    }
    return false;
  }

  static Future<bool> deleteTask({required String id}) async {
    var headersList = {
      'Authorization':
          'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
    };
    var url = Uri.parse(
        'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks/$id');

    var body = {
      "token": "javier",
    };

    var req = await http.delete(url, body: body, headers: headersList);

    if (req.statusCode == 201) {
      return true;
    }
    return false;
  }

  static Future<bool> updateTask(
      {String? id,
      String? tittle,
      String? dueDate,
      String? comments,
      String? description,
      String? tags,
      String? isCompleted}) async {
    var headersList = {
      'Authorization':
          'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
    };
    var url = Uri.parse(
        'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks/$id');

    var body = {
      "token": "javier",
      "title": tittle,
      "is_completed": isCompleted,
      "due_date": dueDate,
      "comments": comments,
      "description": description,
      "tags": tags,
    };

    var req = await http.put(url, body: body, headers: headersList);

    if (req.statusCode == 201) {
      return true;
    }
    return false;
  }
}
