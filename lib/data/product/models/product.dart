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
  final String description;
  final String title;

  ProductModel({
    required this.categoryId, 
    required this.createdDate, 
    required this.discountedPrice, 
    required this.price, 
    required this.images, 
    required this.productId, 
    required this.salesNumber, 
    required this.description,
    required this.title
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
  return ProductModel(
    productId: map['productId'] as String? ?? '',
    title: map['title'] as String? ?? '',
    categoryId: map['categoryId'] as String? ?? '',
    price: map['price'] is num ? map['price'].toDouble() : 0.0,
    discountedPrice: map['discountedPrice'] is num ? map['discountedPrice'].toDouble() : 0.0,
    images: (map['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    salesNumber: map['salesNumber'] as int? ?? 0,
    description: map['description'] as String? ?? '', // Map the description
    createdDate: map['createdDate'] as Timestamp? ?? Timestamp.now(),
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
      "description": description,
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
      description: description,
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
      description: description,
      title: title
    );
  }
}