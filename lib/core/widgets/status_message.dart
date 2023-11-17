import 'package:flutter/material.dart';

enum StatusMessageType { error, success, info }

class StatusMessage extends StatelessWidget {
  const StatusMessage({Key? key, this.type = StatusMessageType.error, this.title, this.message, this.children}) : super(key: key);

  final StatusMessageType type;
  final String? title;
  final String? message;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    late Color backgroundColor;
    late Color textColor;

    if (type == StatusMessageType.error) {
      backgroundColor = Theme.of(context).colorScheme.errorContainer;
      textColor = Theme.of(context).colorScheme.onErrorContainer;
    }
    // else if (type == StatusMessageType.success) {
    //   backgroundColor = Theme.of(context).colorScheme.;
    //   textColor = Palette.colorTextSuccess;
    // }
    else /* if (type == BuStatusMessageType.info) */ {
      backgroundColor = Theme.of(context).colorScheme.primaryContainer;
      textColor = Theme.of(context).colorScheme.onPrimaryContainer;
    }

    return DefaultTextStyle(
      style: TextStyle(color: textColor),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null && title!.isNotEmpty) ...{
              Text(
                title!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
            },
            if (message != null && message!.isNotEmpty) Text(message!),
            if (children != null && children!.isNotEmpty) ...[
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children!,
              ),
              const SizedBox(
                height: 15,
              )
            ]
          ],
        ),
      ),
    );
  }
}
