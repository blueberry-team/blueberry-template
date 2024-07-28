import 'package:flutter/material.dart';

import '../../model/DogProfileModel.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppTextStyle.dart';

/// SwipeCardWidget - 프로필 카드를 스와이프할 수 있는 위젯

class SwipeCardWidget extends StatelessWidget {
  final DogProfileModel dogProfiles;

  const SwipeCardWidget(
    this.dogProfiles, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(dogProfiles.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [richBlack.withOpacity(0.8), richBlack.withOpacity(0)],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.03, horizontal: width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      dogProfiles.name,
                      style: white24BoldTextStyle,
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      '${dogProfiles.gender} • ${dogProfiles.breed} • ${dogProfiles.location}',
                      style: white16TextStyle,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.005),
                Text(
                  dogProfiles.bio,
                  style: white16TextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
