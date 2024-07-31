import 'package:blueberry_flutter_template/providers/user/UserMemberShipProvider.dart';
import 'package:blueberry_flutter_template/services/InAppPurchaseService.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:blueberry_flutter_template/widgets/MiniAvatarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FixSettingAccountManager extends ConsumerStatefulWidget {
  const FixSettingAccountManager({super.key});

  @override
  ConsumerState<FixSettingAccountManager> createState() => _FixSettingAccountManagerState();
}

class _FixSettingAccountManagerState extends ConsumerState<FixSettingAccountManager> {
  bool showNumber = false;
  final InAppPurchaseService _purchaseService = InAppPurchaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _purchaseService.initStoreInfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _purchaseService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userMemberShipState = ref.watch(userMemberShipProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("나의 계정 관리"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                MiniAvatar(),
                SizedBox(
                  width: 20,
                ),
                Text("홍길동"),
              ],
            ),
          ),
          const Divider(),
            ListTile(
                leading: const Icon(Icons.call),
                title: showNumber ? const Text("010-1234-5678") : const Text("010-**34-56**"),
                trailing: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      showNumber = !showNumber;
                    });
                  },
                  child: Container(
                    child: const Text("보이기"),
                  ),
                ),
              ),
          const Divider(),
             ListTile(
                leading: const Icon(Icons.email),
                title: userMemberShipState.isMembership
                      ? const Text(AppStrings.isUserMembership)
                      : const Text(AppStrings.notUserMembership),
                trailing: _inAppPurchaseBtn(userMemberShipState, context),
              ),
        ],
      ),
    );
  }

  ElevatedButton _inAppPurchaseBtn(UserMemberShipState userMemberShipState, BuildContext context) {
    return ElevatedButton(
                onPressed: userMemberShipState.isMembership
                    ? null  // 이미 멤버십이 있으면 버튼 비활성화
                    : () async {
                  try {
                    await _purchaseService.buyMembership();
                    // 구매 성공 시 상태 업데이트 또는 사용자에게 알림
                    await ref.watch(userMemberShipProvider.notifier).loadMembershipStatus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(AppStrings.successMessage_membership)),
                    );
                  } catch (e) {
                    // 구매 실패 시 에러 처리
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(AppStrings.errorMessage_purchase)),
                    );
                  }
                },
                child: Container(
                  child: userMemberShipState.isMembership ? null : const Text("가입 하기"),
                ),
              );
  }
}
