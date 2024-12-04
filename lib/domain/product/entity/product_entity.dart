import 'package:cloud_firestore/cloud_firestore.dart';

class ProductEntity {
  final String categoryId;
  final Timestamp createdDate;
  final num discountedPrice;
  final num price;
  final List<String> images;
  final String productId;
  final int salesNumber;
  final String title;

  ProductEntity({
    required this.categoryId, 
    required this.createdDate, 
    required this.discountedPrice, 
    required this.price, 
    required this.images, 
    required this.productId, 
    required this.salesNumber, 
    required this.title
  });
}

