import 'package:blueberry_flutter_template/providers/user/UserInfoProvider.dart';
import 'package:blueberry_flutter_template/services/PaymentService.dart';
import 'package:blueberry_flutter_template/services/PredefinedItems.dart';
import 'package:bootpay/model/payload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class WebPaymentWidget extends ConsumerStatefulWidget {
  static const String name = 'WebPaymentWidget';
  const WebPaymentWidget({super.key});


  @override
  ConsumerState<WebPaymentWidget> createState() => _WebPaymentWidgetState();
}

class _WebPaymentWidgetState extends ConsumerState<WebPaymentWidget> {

  Payload payload = Payload();

  @override
  Widget build(BuildContext context) {
    final userDataState = ref.watch(getUserDataProvider);

        return Column(
          children: [
            Center(
                child: userDataState.when(
                  data: (userData)
                    => TextButton(
                        onPressed: () => PaymentService().requestPayment(
                            userData['name'] ?? 'Unknown',
                            userData['email'] ?? 'No email',
                            PredefinedItems.premiumMembership
                        ),
                        child: const Text('통합결제 테스트', style: TextStyle(fontSize: 16.0))
                    ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
              )
            )
          ],
        );
  }
}

