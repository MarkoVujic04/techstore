import 'package:techstore/domain/order/entities/product_ordered.dart';

class ProductOrderedModel {
  final String productId;
  final String productTitle;
  final double productPrice;
  final String productImage;
  final double totalPrice;
  final String createdDate;
  final String id;

  ProductOrderedModel({
    required this.productId, 
    required this.productTitle, 
    required this.productPrice, 
    required this.productImage,
    required this.totalPrice,
    required this.createdDate,
    required this.id,
  });

  factory ProductOrderedModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderedModel(
      productId: map['productId'] as String,
      productTitle: map['productTitle'] as String,
      productPrice: map['productPrice'] as double,
      productImage: map['productImage'] as String,
      totalPrice: (map['totalPrice'] ?? map['productPrice']) as double,
      createdDate: map['createdDate'] as String,
      id: map["id"] as String,
    );
  }

   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productTitle': productTitle,
      'productPrice': productPrice,
      'totalPrice': totalPrice,
      'productImage': productImage,
      'createdDate': createdDate,
      'id': id,
    };
  }
 
 
}

extension ProductOrderedXModel on ProductOrderedModel {
  ProductOrderedEntity toEntity() {
    return ProductOrderedEntity(
      productId: productId, 
      productTitle: productTitle, 
      productPrice: productPrice, 
      productImage: productImage, 
      totalPrice: totalPrice,
      createdDate: createdDate,
      id: id,
    );
  }
}

extension ProductOrderedXEntity on ProductOrderedEntity {
  ProductOrderedModel fromEntity() {
    return ProductOrderedModel(
      productId: productId, 
      productTitle: productTitle, 
      productPrice: productPrice, 
      productImage: productImage, 
      totalPrice: totalPrice,
      createdDate: createdDate,
      id: id,
    );
  }
}