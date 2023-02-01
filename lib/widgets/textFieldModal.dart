import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:todolist/style/Colors.dart';

class TextFieldModal extends StatefulWidget {
  TextFieldModal(
      {super.key,
      this.title,
      this.subtitle,
      this.valueChange,
      this.isDate,
      this.insideValue});
  String? title;
  String? subtitle;
  RxString? valueChange;
  bool? isDate;
  String? insideValue;
  @override
  State<TextFieldModal> createState() => _TextFieldModalState();
}

class _TextFieldModalState extends State<TextFieldModal> {
  // This validation is made just for the date textField
  var dateFormater = MaskTextInputFormatter(
      mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    

    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        // This controller works when we need to pass a certain value to the TextField
        controller: widget.insideValue != null ? TextEditingController(text:widget.insideValue) : null,
        style: const TextStyle(color: Colors.white),
        inputFormatters: widget.isDate == true ? [dateFormater] : null,
        decoration: getDecoration(),
        onChanged: (value) {
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
