import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:todolist/style/Colors.dart';

class TextFieldModal extends StatefulWidget {
  TextFieldModal(
      {super.key, this.title, this.subtitle, this.valueChange, this.isDate});
  String? title;
  String? subtitle;
  RxString? valueChange;
  bool? isDate;
  @override
  State<TextFieldModal> createState() => _TextFieldModalState();
}

class _TextFieldModalState extends State<TextFieldModal> {
  var dateFormater = MaskTextInputFormatter(
      mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        inputFormatters: widget.isDate == true ? [dateFormater] : null,
        decoration: getDecoration(),
        onChanged: (value) {
          print(value);
          widget.valueChange?.value = value;
        },
      ),
    );
  }

  InputDecoration getDecoration() {
    OutlineInputBorder borderTextField = const OutlineInputBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        borderSide: BorderSide(width: 1, color: Colors.white));
    return InputDecoration(
        hintText: widget.subtitle,
        hintStyle: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3)),
        labelText: widget.title,
        labelStyle: const TextStyle(color: Colors.white),
        focusedBorder: borderTextField,
        enabledBorder: borderTextField);
  }
}
