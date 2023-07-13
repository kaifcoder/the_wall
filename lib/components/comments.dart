import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final String text, username, time;
  const Comments(
      {super.key,
      required this.text,
      required this.username,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(text),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(username),
              Text("*"),
              Text(time),
            ],
          ),
        ],
      ),
    );
  }
}
