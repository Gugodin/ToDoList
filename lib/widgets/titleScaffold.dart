import 'package:flutter/material.dart';

class TitleScaffold extends StatelessWidget {
  const TitleScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('¿Que haremos hoy?',
        style: TextStyle(
            fontSize: 25, letterSpacing: 5, fontWeight: FontWeight.w300),);
  }
}