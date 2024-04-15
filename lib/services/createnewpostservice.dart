import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';

class NewPostService {
  static Future<String?> createNewPost({
    required String productName,
    required double oldPrice,
    required double newPrice,
    required File priceTagImage,
    required File productImage,
    required int newQuantity,
    required int oldQuantity,
    required String storePlaceId,
  }) async {
    try {
      const String apiUrl = '${ApiConfig.baseUrlPost}/post';
      print('$productName, $storePlaceId, $newQuantity');

      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      print('access-token-${accessToken}');

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final headers = {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      };

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers.addAll(headers);

      // Function to check if the file has a JPEG extension
      bool isJPEG(File file) {
        String extension = file.path.split('.').last.toLowerCase();
        return extension == 'jpg' || extension == 'jpeg';
      }

      // Add priceTagImage if it's a JPEG file
      if (isJPEG(priceTagImage)) {
        request.files.add(http.MultipartFile(
          'priceTagImage',
          priceTagImage.readAsBytes().asStream(),
          priceTagImage.lengthSync(),
          filename: priceTagImage.path.split('/').last,
        ));
      } else {
        throw Exception('priceTagImage must be a JPEG file');
      }

      // Add productImage if it's a JPEG file
      if (isJPEG(productImage)) {
        request.files.add(http.MultipartFile(
          'productImage',
          productImage.readAsBytes().asStream(),
          productImage.lengthSync(),
          filename: productImage.path.split('/').last,
        ));
      } else {
        throw Exception('productImage must be a JPEG file');
      }

      // Add other fields to the request
      request.fields['productName'] = productName;
      request.fields['oldPrice'] = oldPrice.toString();
      request.fields['newPrice'] = newPrice.toString();
      request.fields['newQuantity'] = newQuantity.toString();
      request.fields['oldQuantity'] = oldQuantity.toString();
      request.fields['storePlaceId'] = storePlaceId;

      var response = await http.Response.fromStream(await request.send());

      if (kDebugMode) {
        print('response-${response.statusCode}, ${response.body}');
      }

      if (response.statusCode == 201) {
        print('New post created successfully');
        return null; // Return null if post creation is successful
      } else {
        // Parse postDeclinedReason from response body
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final postDeclinedReason = responseBody['postDeclinedReason'];
        return postDeclinedReason; // Return postDeclinedReason if creation fails
      }
    } catch (error) {
      throw Exception('Failed to create new post: $error');
    }
  }
}


