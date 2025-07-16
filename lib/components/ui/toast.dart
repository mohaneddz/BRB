import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:brb/styles/style.dart';

enum ToastType { warning, info, error }

class Toast extends StatefulWidget {
  final String message;
  final ToastType type;
  final VoidCallback? onDismissed;

  const Toast({
    super.key,
    required this.message,
    required this.type,
    this.onDismissed,
  });

  @override
  State<Toast> createState() => _ToastState();

  static IconData _iconForType(ToastType type) {
    switch (type) {
      case ToastType.warning:
        return LucideIcons.alertTriangle;
      case ToastType.info:
        return LucideIcons.info;
      case ToastType.error:
        return LucideIcons.xCircle;
    }
  }

  // Only use red, but vary shade for degree of danger
  static Color _colorForType(ToastType type) {
    switch (type) {
      case ToastType.warning:
        return AppColors.accent.withOpacity(0.7); // lighter red
      case ToastType.info:
        return AppColors.primary.withOpacity(0.5); // faint red
      case ToastType.error:
        return AppColors.primary; // full red
    }
  }

  static Color _bgForType(ToastType type) {
    switch (type) {
      case ToastType.warning:
        return AppColors.darkBgLight;
      case ToastType.info:
        return AppColors.darkBg;
      case ToastType.error:
        return AppColors.darkBgLight;
    }
  }
}

class _ToastState extends State<Toast> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onDismissed?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.message + widget.type.toString()),
      direction: DismissDirection.up,
      onDismissed: (_) => widget.onDismissed?.call(),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Toast._bgForType(widget.type),
            border: Border.all(
              color: Toast._colorForType(widget.type),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Toast._iconForType(widget.type),
                color: Toast._colorForType(widget.type),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.message,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.enabledText,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}