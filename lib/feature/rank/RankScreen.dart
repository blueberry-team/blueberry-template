import 'package:flutter/material.dart';
import 'package:blueberry_flutter_template/feature/rank/widget/RankViewWidget.dart';

final class RankingScreen extends StatelessWidget {
  static const String name = 'RankingScreen';
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RankViewWidget();
  }
}
