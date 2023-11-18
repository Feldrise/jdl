import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GameModeButton extends StatelessWidget {
  const GameModeButton({super.key, required this.color, required this.mode, this.onRemove});

  final Color color;
  final String mode;
  final Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: color),
        borderRadius: BorderRadius.circular(64),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onRemove != null) ...[
            InkWell(
                onTap: onRemove,
                child: Icon(
                  LucideIcons.x,
                  color: color,
                  size: 16,
                )),
            const SizedBox(
              width: 4,
            ),
          ],
          Text(mode,
              style: TextStyle(
                color: color,
              )),
        ],
      ),
    );
  }
}
