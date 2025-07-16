import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart'; // Add this import

class MySettingRow extends StatelessWidget {
  final String label;
  final Widget child;
  final double? width;
  final String align;
  final bool inline;
  final IconData? icon; // Add this line

  const MySettingRow({
    super.key,
    required this.label,
    required this.child,
    this.width,
    this.align = 'mid',
    this.inline = false,
    this.icon, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        Widget labelWidget = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Icon(icon, color: Colors.red, size: 16),
              ),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: inline ? 10 : 12,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        );

        if (inline) {
          // Inline layout for checkboxes
          return Row(
            children: [
              Expanded(child: labelWidget),
              child,
            ],
          );
        } else {
          // Vertical layout for sliders
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              labelWidget,
              const SizedBox(height: 1),
              SizedBox(width: availableWidth, child: child),
            ],
          );
        }
      },
    );
  }
}
