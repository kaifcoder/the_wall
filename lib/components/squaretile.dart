import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String file;
  final Function()? onTap;

  const SquareTile({
    super.key,
    required this.file,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Image.asset(
          file,
          height: 50,
        ),
      ),
    );
  }
}
