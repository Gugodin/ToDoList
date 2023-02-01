import 'package:flutter/material.dart';

class CheckBoxCard extends StatefulWidget {
  CheckBoxCard({super.key, this.isChecked});
  bool? isChecked;
  @override
  State<CheckBoxCard> createState() => _CheckBoxCardState();
}

class _CheckBoxCardState extends State<CheckBoxCard> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.isChecked,
      onChanged: (value) {
        setState(() {
          widget.isChecked = value;
        });
      },
    );
  }
}
