import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/SaleItemModel.freezed.dart';
part 'generated/SaleItemModel.g.dart';


@freezed
class SaleItemModel with _$SaleItemModel {
  const factory SaleItemModel({
    required int id,
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String imageUrl,
  }) = _SaleItem;

  factory SaleItemModel.fromJson(Map<String, dynamic> json) => _$SaleItemModelFromJson(json);
}

