import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techstore/domain/product/entity/product_entity.dart';

class ProductModel {
  final String categoryId;
  final Timestamp createdDate;
  final num discountedPrice;
  final num price;
  final List<String> images;
  final String productId;
  final int salesNumber;
  final String title;

  ProductModel({
    required this.categoryId, 
    required this.createdDate, 
    required this.discountedPrice, 
    required this.price, 
    required this.images, 
    required this.productId, 
    required this.salesNumber, 
    required this.title
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
  return ProductModel(
    categoryId: map['categoryId'] as String? ?? '',
    createdDate: map['createdDate'] as Timestamp? ?? Timestamp.now(),
    discountedPrice: map['discountedPrice'] is num
        ? map['discountedPrice'] as num
        : num.tryParse(map['discountedPrice'].toString()) ?? 0,
    images: (map['images'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
    price: map['price'] is num
        ? map['price'] as num
        : num.tryParse(map['price'].toString()) ?? 0,
    productId: map['productId'] as String? ?? '',
    salesNumber: map['salesNumber'] is int
        ? map['salesNumber'] as int
        : int.tryParse(map['salesNumber'].toString()) ?? 0,
    title: map['title'] as String? ?? '',
  );
}


   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'createdDate': createdDate,
      'discountedPrice': discountedPrice,
      'images': images.map((e) => e.toString()).toList(),
      'price': price,
      'productId': productId,
      'salesNumber': salesNumber,
      'title': title,
    };
  }

}

extension ProductXModel on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      categoryId: categoryId,
      createdDate: createdDate,
      discountedPrice: discountedPrice,
      images: images, 
      price: price,
      productId: productId, 
      salesNumber: salesNumber, 
      title: title
    );
  }
}

extension ProductXEntity on ProductEntity {
  ProductModel fromEntity() {
    return ProductModel(
      categoryId: categoryId,
      createdDate: createdDate,
      discountedPrice: discountedPrice,
      images: images, 
      price: price,
      productId: productId, 
      salesNumber: salesNumber, 
      title: title
    );
  }
}