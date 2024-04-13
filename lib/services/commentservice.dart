import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';

class CommentService {
  static Future<Map<String, dynamic>> createComment(String currentUser, String postId, String comment) async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlComment}${ApiConfig.addCommentEndpoint}'; // Adjust the API endpoint

      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json', // Specify content type as JSON
        'Authorization': 'Bearer $accessToken', // Add the access token to the headers
      };

      final Map<String, dynamic> requestBody = {
        'userId': currentUser,
        'postId': postId,
        'comment': comment,
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
}
