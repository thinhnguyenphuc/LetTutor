import 'package:flutter/material.dart';

class IconHero extends StatelessWidget {
  const IconHero({Key? key, this.onTap, required this.tag, required this.child})
      : super(key: key);

  final VoidCallback? onTap;
  final String tag;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Hero(
        tag: tag,
        child: Material(
          color: Colors.transparent,
          child: onTap != null
              ? InkWell(
                  onTap: onTap,
                  child: child,
                )
              : child,
        ),
      ),
    );
  }
}
