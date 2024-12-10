class ProductOrderedEntity {
  final String productId;
  final String productTitle;
  final double productPrice;
  final String productImage;
  final double totalPrice;
  final String createdDate;
  final String id;

  ProductOrderedEntity({
    required this.productId, 
    required this.productTitle, 
    required this.productPrice, 
    required this.productImage,
    required this.totalPrice, 
    required this.createdDate,
    required this.id,
  });
}