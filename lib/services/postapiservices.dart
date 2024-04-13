import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';

class PostApiService {
  static Future<bool> deletePost(String postId) async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlPost}${ApiConfig.deletePostEndpoint}';
      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Include authorization header
        },
        body: jsonEncode({'postId': postId}), // Convert the payload to JSON string
      );

      if (response.statusCode == 200) {
        // Post successfully deleted
        return true;
      } else if (response.statusCode == 400) {
        // Post does not exist
        print('Post does not exist');
        return false;
      } else {
        // Failed to delete post
        print('Failed to delete post: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // Exception occurred during request
      print('Error deleting post: $error');
      return false;
    }
  }
}
