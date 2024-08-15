import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../friend/widget/FilterMenuWidget.dart';
import '../provider/MatchScreenProvider.dart';

class MatchFilterWidget extends ConsumerStatefulWidget {
  const MatchFilterWidget({super.key});

  @override
  ConsumerState<MatchFilterWidget> createState() => _MatchFilterWidgetState();
}

class _MatchFilterWidgetState extends ConsumerState<MatchFilterWidget> {
  String? selectedLocation;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260, // 바텀 시트 높이 수정 부분
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    '어떤 친구를 만날까요?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilterMenuWidget(
            label: '지역',
            selectedValue: selectedLocation,
            onChanged: (newValue) => setState(() {
              selectedLocation = newValue;
            }),
            items: ['Seoul', 'LA', 'Hawaii', 'Japan'],
          ),
          const SizedBox(height: 16),
          FilterMenuWidget(
            label: '성별',
            selectedValue: selectedGender,
            onChanged: (newValue) => setState(() {
              selectedGender = newValue;
            }),
            items: ['male', 'female'],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(matchScreenProvider.notifier).loadPets(
                location: selectedLocation,
                gender: selectedGender,
              );
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text(
              '만나기',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

