import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSize {
  String title;

  TopBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement child
  Widget get child => const Text("Error");

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0);
}
