import 'package:flutter/material.dart';

class BackgroundedButton extends StatelessWidget {
  const BackgroundedButton({super.key, required this.child, required this.image, required this.color, required this.onPressed});

  final Widget child;
  final Color color;
  final String image;

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        // elevation: 0,
        color: color,
        surfaceTintColor: color,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), alignment: Alignment.bottomRight),
          ),
          child: child,
        ),
      ),
    );
  }
}
