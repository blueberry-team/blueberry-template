import 'package:flutter/material.dart';

import '../../../utils/AppStrings.dart';

class OptionMenuWidget extends StatelessWidget {
  final Function(String) onOptionSelected;

  const OptionMenuWidget({super.key, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: onOptionSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'ignore',
          child: Row(
            children: [
              Icon(Icons.block, color: Colors.red[400], size: 14),
              const SizedBox(width: 8),
              Text(AppStrings.ignoreThisPet,
                  style: TextStyle(color: Colors.red[400])),
            ],
          ),
        ),
      ],
    );
  }
}
