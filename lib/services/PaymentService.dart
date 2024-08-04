import 'package:blueberry_flutter_template/model/SaleItemModel.dart';
import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/payload.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bootpay/model/user.dart' as BootpayUser;

// payment_service.dart

class PaymentService {

  Future<void> requestPayment(String username, String userEmail, SaleItemModel item ) async {
        String webApplicationId = 'put your JS API key here';
        String androidApplicationId = 'put your Android API key here';
        String iosApplicationId = 'put your iOS API key here';

        Payload payload = Payload();
        payload.androidApplicationId = androidApplicationId;
        payload.iosApplicationId = iosApplicationId;
        payload.webApplicationId = webApplicationId;

        if (kIsWeb) {
          payload.extra?.openType = "iframe";
        }

        payload.pg = 'KCP';
        payload.methods = ['card', 'phone', 'vbank', 'bank', 'kakao', 'naver'];

        payload.orderName = item.name;
        payload.price = item.price * item.quantity;
        payload.orderId = DateTime.now().millisecondsSinceEpoch.toString();

        BootpayUser.User user = BootpayUser.User();
        user.username = username;
        user.email = userEmail;
        user.phone = '010-1234-5678';
        user.addr = '서울시 어딘가';

        try {
          Bootpay().requestPayment(
            payload: payload,
            showCloseButton: false,
            closeButton: const Icon(Icons.close, size: 35.0, color: Colors.black54),
            onDone: (String data) async {
              print('결제 완료: $data');
              try {
                HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('verifyPayment');
                // fuctions 폴더의 verifyPayment 함수 호출
                final result = await callable.call({
                  'paymentData': data,
                  'itemId': item.id,
                  'userId': userEmail,
                  'itemPrice': item.price,
                });
                print('영수증 처리 결과: ${result.data}');
                // 결과에 따른 추가 처리
              } catch (e) {
                print('영수증 처리 중 오류 발생: $e');
              }
            },
            onCancel: (String data) {
              print('결제 취소: $data');
              // 결제 취소 후 처리 로직
            },
            onError: (String data) {
              print('결제 에러: $data');
              // 결제 에러 후 처리 로직
            },
          );
        } catch (e) {
          print('결제 처리 중 에러 발생: $e');
        }
      }
}