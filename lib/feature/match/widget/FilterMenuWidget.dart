import 'package:flutter/material.dart';

class FilterMenuWidget extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final void Function(String?) onChanged;
  final List<String> items;

  const FilterMenuWidget({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
