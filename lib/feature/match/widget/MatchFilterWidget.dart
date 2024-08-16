import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/AppStrings.dart';
import 'FilterMenuWidget.dart';
import '../provider/MatchScreenProvider.dart';

enum Location { seoul, la, hawaii, japan }

enum Gender { male, female }

String getLocationDisplayName(Location location) {
  switch (location) {
    case Location.seoul:
      return 'Seoul';
    case Location.la:
      return 'LA';
    case Location.hawaii:
      return 'Hawaii';
    case Location.japan:
      return 'Japan';
  }
}

String getGenderDisplayName(Gender gender) {
  return gender.toString().split('.').last.toLowerCase();
}

class MatchFilterWidget extends ConsumerStatefulWidget {
  const MatchFilterWidget({super.key});

  @override
  ConsumerState<MatchFilterWidget> createState() => _MatchFilterWidgetState();
}

class _MatchFilterWidgetState extends ConsumerState<MatchFilterWidget> {
  Location? selectedLocation;
  Gender? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 282,
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
                    AppStrings.filterTitle,
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
            label: AppStrings.petLocation,
            selectedValue: selectedLocation != null
                ? getLocationDisplayName(selectedLocation!)
                : null,
            onChanged: (newValue) => setState(() {
              selectedLocation = Location.values.firstWhere(
                (location) => getLocationDisplayName(location) == newValue,
                orElse: () => Location.seoul,
              );
            }),
            items: Location.values
                .map((location) => getLocationDisplayName(location))
                .toList(),
          ),
          const SizedBox(height: 16),
          FilterMenuWidget(
            label: AppStrings.petGender,
            selectedValue: selectedGender != null
                ? getGenderDisplayName(selectedGender!)
                : null,
            onChanged: (newValue) => setState(() {
              selectedGender = Gender.values.firstWhere(
                (gender) => getGenderDisplayName(gender) == newValue,
                orElse: () => Gender.male,
              );
            }),
            items: Gender.values
                .map((gender) => getGenderDisplayName(gender))
                .toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(matchScreenProvider.notifier).loadPets(
                    location: selectedLocation != null
                        ? getLocationDisplayName(selectedLocation!)
                        : null,
                    gender: selectedGender != null
                        ? getGenderDisplayName(selectedGender!)
                        : null,
                  );
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text(
              AppStrings.filterSubmitButtonText,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
