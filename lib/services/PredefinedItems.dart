import 'package:blueberry_flutter_template/model/SaleItemModel.dart';

class PredefinedItems {
  static const SaleItemModel premiumMembership = SaleItemModel(
    id: 1,
    name: '프리미엄 회원',
    description: '프리미엄 회원 가입',
    price: 1000,
    quantity: 1,
    imageUrl: 'assets/images/premium_membership.png',
  );

  // 결제 아이템을 변경해도 적용 가능한지 체크 하기 위해 추가함 (테스트용)
  static const SaleItemModel basicMembership = SaleItemModel(
    id: 2,
    name: '기본 회원',
    description: '기본 회원 가입',
    price: 500,
    quantity: 1,
    imageUrl: 'assets/images/basic_membership.png',
  );

  static SaleItemModel getItemById(int id) {
    switch (id) {
      case 1:
        return premiumMembership;
      case 2:
        return basicMembership;
      // 더 많은 케이스...
      default:
        throw Exception("Unknown item id: $id");
    }
  }
}
