import 'package:flutter/material.dart';

class CommentBtn extends StatelessWidget {
  final void Function()? onTap;
  const CommentBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.comment,
        color: Colors.grey,
      ),
    );
  }
}
