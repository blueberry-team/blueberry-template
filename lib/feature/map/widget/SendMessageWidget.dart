import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SendMessage extends StatelessWidget {
  final LatLng locationState;

  const SendMessage({
    super.key,
    required this.locationState,
  });

  @override
  Widget build(BuildContext context) {
    final String message =
        '[메세지] 위급상황이 발생했습니다. 도와주세요!\n (위도: ${locationState.latitude} / 경도: ${locationState.longitude})';

    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: () async {
              final Uri smsUri = Uri(
                scheme: 'sms',
                path: '112',
                queryParameters: <String, String>{
                  'body': message,
                },
              );

              if (await canLaunchUrl(smsUri)) {
                await launchUrl(smsUri);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Text(AppStrings.errorMessage_sendFailed),
                    );
                  },
                );
              }
            },
            child: const Text(AppStrings.button_sendMessage),
          ),
        ],
      ),
    );
  }
}
