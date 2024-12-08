class AddToCartReq {
  final String productId;
  final String productTitle;
  final double productPrice;
  final String productImage;
  final String createdDate;

  AddToCartReq({
    required this.productId, 
    required this.productTitle, 
    required this.productPrice, 
    required this.productImage,
    required this.createdDate
  });

   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productTitle': productTitle,
      'productPrice': productPrice,
      'productImage': productImage,
      'createdDate': createdDate,
    };
  }
}