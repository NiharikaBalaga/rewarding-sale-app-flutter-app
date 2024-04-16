class Post {
  final String id;
  final String userId;
  final String status;
  final bool isActive;
  final String priceTagImageS3Uri;
  final String priceTagImageObjectUrl;
  final String productImageS3Uri;
  final String productImageObjectUrl;
  final String productName;
  final double oldPrice;
  final double newPrice;
  final int oldQuantity;
  final int newQuantity;
  final String storePlaceId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String postCategory;
  final String storeAddress;
  final String storeCountryLongName;
  final String storeCountryShortName;
  final String storeName;
  final String storePostalCode;
  final String storeProvinceLongName;
  final String storeProvinceShortName;
  final String storeUrl;
  List<String>? comments; // Make comments nullable
  final String? postDeclinedReason;

  Post({
    required this.id,
    required this.userId,
    required this.status,
    required this.isActive,
    required this.priceTagImageS3Uri,
    required this.priceTagImageObjectUrl,
    required this.productImageS3Uri,
    required this.productImageObjectUrl,
    required this.productName,
    required this.oldPrice,
    required this.newPrice,
    required this.oldQuantity,
    required this.newQuantity,
    required this.storePlaceId,
    required this.createdAt,
    required this.updatedAt,
    required this.postCategory,
    required this.storeAddress,
    required this.storeCountryLongName,
    required this.storeCountryShortName,
    required this.storeName,
    required this.storePostalCode,
    required this.storeProvinceLongName,
    required this.storeProvinceShortName,
    required this.storeUrl,
    this.comments, // Make comments nullable
    this.postDeclinedReason,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      status: json['status'] ?? '',
      isActive: json['isActive'] ?? false,
      priceTagImageS3Uri: json['priceTagImageS3Uri'] ?? '',
      priceTagImageObjectUrl: json['priceTagImageObjectUrl'] ?? '',
      productImageS3Uri: json['productImageS3Uri'] ?? '',
      productImageObjectUrl: json['productImageObjectUrl'] ?? '',
      productName: json['productName'] ?? '',
      oldPrice: json['oldPrice'] != null
          ? double.parse(json['oldPrice'].toString())
          : 0.0,
      newPrice: json['newPrice'] != null
          ? double.parse(json['newPrice'].toString())
          : 0.0,
      oldQuantity: json['oldQuantity'] ?? 0,
      newQuantity: json['newQuantity'] ?? 0,
      storePlaceId: json['storePlaceId'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
      postCategory: json['postCategory'] ?? '',
      storeAddress: json['storeAddress'] ?? '',
      storeCountryLongName: json['storeCountryLongName'] ?? '',
      storeCountryShortName: json['storeCountryShortName'] ?? '',
      storeName: json['storeName'] ?? '',
      storePostalCode: json['storePostalCode'] ?? '',
      storeProvinceLongName: json['storeProvinceLongName'] ?? '',
      storeProvinceShortName: json['storeProvinceShortName'] ?? '',
      storeUrl: json['storeUrl'] ?? '',
      comments: json['comments'] != null
          ? List<String>.from(json['comments'])
          : null, // Initialize comments as an empty list if not provided
      postDeclinedReason: json['postDeclinedReason'],
    );
  }
}
