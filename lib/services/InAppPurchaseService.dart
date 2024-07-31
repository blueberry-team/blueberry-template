import 'dart:async';

import 'package:blueberry_flutter_template/providers/user/UserMemberShipProvider.dart';
import 'package:blueberry_flutter_template/services/FirebaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:io';





class InAppPurchaseService {
  static const String _kIosProductId = 'com.gaeting.example.userLevel';
  static const String _kAndroidProductId = 'your_android_product_id';

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;

  final firebaseService = FirebaseService();

  InAppPurchaseService() {
    initStoreInfo();
  }

  void initStoreInfo() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      // 결제가 끝났을 때 처리
    }, onError: (error) {
      // 에러 처리
    });
  }

  Future<void> buyMembership() async {
    final String productId = Platform.isIOS ? _kIosProductId : _kAndroidProductId;

    final ProductDetails product = await _getProductDetails(productId);

    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);

    try {
      final bool success = await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
      if (!success) {
        throw Exception('Purchase failed');
      }
    } catch (e) {
      print('Error during purchase: $e');
      rethrow;
    }
  }

  Future<ProductDetails> _getProductDetails(String productId) async {
    final ProductDetailsResponse response =
    await _inAppPurchase.queryProductDetails({productId});

    if (response.notFoundIDs.isNotEmpty) {
      throw Exception('Product not found');
    }

    return response.productDetails.first;
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        // 구매 완료
        await _verifyPurchase(purchaseDetails);
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // 구매 오류
        print('Error: ${purchaseDetails.error}');
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    // 결제처리가 완료되면 여기서 서버에 업데이트를 요청합니다.
    const String membershipProductID = 'com.gaeting.example.userLevel';
    if (purchaseDetails.productID == membershipProductID) {
      await firebaseService.updateUserMemberShip();
    }
  }
  void dispose() {
    subscription.cancel();
    // 기타 필요한 정리 작업
  }
}
