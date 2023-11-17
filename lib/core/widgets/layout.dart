import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width > 600 ? 20 : 0),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width > 600 ? 16 : 0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: child,
          ),
        ),
      ),
    );
  }
}
