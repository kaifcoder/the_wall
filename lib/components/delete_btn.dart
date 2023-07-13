import 'package:flutter/material.dart';

class Deletebutton extends StatelessWidget {
  final void Function()? onPressed;
  const Deletebutton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        Icons.delete,
        color: Colors.red[500],
      ),
    );
  }
}
