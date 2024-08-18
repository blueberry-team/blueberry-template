import 'package:flutter/material.dart';

class CustomFab extends StatefulWidget {
  final List<FabButton> fabButtons;
  final Color mainColor;
  final IconData mainIcon;

  const CustomFab({
    super.key,
    required this.fabButtons,
    this.mainColor = Colors.blue,
    this.mainIcon = Icons.add,
  });

  @override
  _CustomFabState createState() => _CustomFabState();
}

class FabButton {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  FabButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color = Colors.blue,
  });
}

class _CustomFabState extends State<CustomFab>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < widget.fabButtons.length; i++)
          AnimatedPositioned(
            bottom: _isExpanded ? (i + 1) * 60.0 + 20.0 : 20.0,
            right: 20,
            duration: const Duration(milliseconds: 300),
            child: AnimatedOpacity(
              opacity: _isExpanded ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                heroTag: 'btn$i',
                onPressed: widget.fabButtons[i].onPressed,
                backgroundColor: widget.fabButtons[i].color,
                tooltip: widget.fabButtons[i].label,
                child: Icon(widget.fabButtons[i].icon),
              ),
            ),
          ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              });
            },
            backgroundColor: widget.mainColor,
            child: Icon(widget.mainIcon),
          ),
        ),
      ],
    );
  }
}
