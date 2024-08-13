import 'package:flutter/material.dart';

///  MatchScreen - 수동으로 좌/우 스와이프를 할 수 있는 버튼
///
/// 추후 디자인이 들어갈 수 있기에 따로 빼놨음

class SwipeButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;

  const SwipeButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color = Colors.white,
  });


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      onPressed: onPressed,
      backgroundColor: color, // 버튼 색상 추가
      child: Icon(icon),
      // 여기에 커스텀 스타일 추가
    );
  }
}
