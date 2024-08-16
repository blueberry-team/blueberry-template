import 'package:blueberry_flutter_template/feature/user/restore/widget/DeletedUserDataWidget.dart';
import 'package:flutter/material.dart';

class RestoreDeletedUserScreen extends StatelessWidget {
  static const String name = '/RestoreDeletedUserScreen';
  const RestoreDeletedUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DeletedUserDataWidget();
  }
}
