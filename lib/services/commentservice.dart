import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';

class CommentService {
  static Future<Map<String, dynamic>> createComment(String postId, String comment) async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlComment}${ApiConfig.addCommentEndpoint}/$postId'; // Adjust the API endpoint to include postId

      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken', // Add the access token to the headers
        'Content-Type': 'application/json', // Specify content type as JSON
      };

      final Map<String, dynamic> requestBody = {
        'comment': comment, // Adjust the request body to include only the comment
      };

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(requestBody), // Encode request body to JSON
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Comment created successfully');
        return responseData;
      } else {
        throw Exception('Failed to create comment: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to create comment: $error');
    }
  }

  static Future<List<dynamic>> getComments(String postId) async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlComment}/comment/comments/$postId';

      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> comments = responseData['comments']; // Extract comments from the response
        print('Comments retrieved successfully');
        return comments;
      } else {
        throw Exception('Failed to retrieve comments: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to retrieve comments: $error');
    }
  }


}
