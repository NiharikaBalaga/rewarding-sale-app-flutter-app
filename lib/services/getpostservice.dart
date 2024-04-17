import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';

class PostService {
 // static const String baseUrl = 'http://localhost:3001/api';
  static Future<List<Post>> fetchAllPosts() async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlPost}${ApiConfig.getPostEndpoint}';
      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Bearer $accessToken', // Include authorization header
          }
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        return responseData.map<Post>((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load posts: $error');
    }
  }

  static Future<Post> fetchPostById(String postId) async {
    try {
      final String apiUrl =
          '${ApiConfig.baseUrlPost}${ApiConfig.getPostId}/$postId';
      final secureStorageService = SecureStorageService();
      final accessToken =
          await secureStorageService.read(SecureStorageService.keyAccessToken);
      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $accessToken', // Include authorization header
      });


      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return Post.fromJson(
            responseData); // Assuming Post.fromJson can handle this structure
      } else {
        if (kDebugMode) {
          print("fetchPostById error no 200");
        }
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load post: $error');
    }
  }
}
