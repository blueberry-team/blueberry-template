import 'package:flutter/material.dart';

class CameraButtonWidget extends StatefulWidget {
  final VoidCallback onTap;

  const CameraButtonWidget({super.key, required this.onTap});

  @override
  State<CameraButtonWidget> createState() => _CameraButtonWidget();
}

class _CameraButtonWidget extends State<CameraButtonWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: ShapeDecoration(
              shape: CircleBorder(
                side: BorderSide(
                  color: _isPressed ? Colors.red : Colors.black12,
                  width: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}