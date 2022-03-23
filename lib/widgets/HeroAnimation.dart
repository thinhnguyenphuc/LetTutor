import 'package:flutter/material.dart';

class IconHero extends StatelessWidget {
  const IconHero({
    Key? key,
    required this.onTap,
    required this.tag,
    required this.child
  }) : super(key: key);

  final VoidCallback onTap;
  final String tag;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Hero(
        tag: tag,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}