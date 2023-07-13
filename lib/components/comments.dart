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
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 16,
              )),
          Row(
            children: [
              Text(
                username,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                ),
              ),
              const Text(" • "),
              Text(
                time,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
