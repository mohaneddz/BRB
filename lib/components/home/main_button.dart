import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LooperButton extends StatefulWidget {
  final String text;
  final VoidCallback onClick;
  final double scaleDown;
  final Duration scaleDuration;
  final Duration opacityDuration;

  const LooperButton({
    super.key,
    required this.text,
    required this.onClick,
    this.scaleDown = 0.92,
    this.scaleDuration = const Duration(milliseconds: 120),
    this.opacityDuration = const Duration(milliseconds: 200),
  });

  @override
  State<LooperButton> createState() => _LooperButtonState();
}

class _LooperButtonState extends State<LooperButton> {
  double _brightness = 1.0;
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = widget.scaleDown;
      _brightness = 0.5;
    });
  }

  void _onTapUp(TapUpDetails details) {
    Future.delayed(widget.scaleDuration, () {
      setState(() {
        _scale = 1.0;
        _brightness = 1.0;
      });
      widget.onClick();
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
      _brightness = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedScale(
            scale: _scale,
            duration: widget.scaleDuration,
            child: AnimatedOpacity(
              opacity: _brightness,
              duration: widget.opacityDuration,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: SvgPicture.asset(
                  'assets/svgs/Looper.svg',
                  width: (MediaQuery.of(context).size.width - 40).clamp(
                    0.0,
                    double.infinity,
                  ),
                  colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          AnimatedScale(
            scale: _scale,
            duration: widget.scaleDuration,
            child: Text(widget.text, style: Theme.of(context).textTheme.headlineMedium),
          ),
        ],
      ),
    );
  }
}
