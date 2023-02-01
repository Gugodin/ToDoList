import 'package:flutter/material.dart';
import 'package:todolist/widgets/titleScaffold.dart';

import '../style/Colors.dart';

class AppBarScaffold extends StatelessWidget implements PreferredSizeWidget {
  const AppBarScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const TitleScaffold(),
      backgroundColor: ColorStyle.backGroundColorBody,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          gradient:
              LinearGradient(colors: [ColorStyle.linear1, ColorStyle.linear2]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
