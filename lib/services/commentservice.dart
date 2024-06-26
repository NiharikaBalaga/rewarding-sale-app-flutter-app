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
      final String apiUrl = '${ApiConfig.baseUrlComment}${ApiConfig.getCommentEndpoint}/$postId';

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
        final List<dynamic> comments = responseData['comments'];
        // Extract comments from the response
        // final List<dynamic> commentsId = responseData['id'];
        // print(commentsId);
        print('Comments retrieved successfully');
        return comments;
      } else {
        throw Exception('Failed to retrieve comments: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to retrieve comments: $error');
    }
  }

  static Future<Map<String, dynamic>> editComment(String commentId, String updatedComment) async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlComment}${ApiConfig.editCommentEndpoint}/$commentId';

      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',

      };

      final Map<String, dynamic> requestBody = {
        'comment': updatedComment,
      };

      final http.Response response = await http.patch(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Comment edited successfully');
        return responseData;
      } else {
        throw Exception('Failed to edit comment: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to edit comment: $error');
    }
  }

  static Future<Map<String, dynamic>> deleteComment(String commentId) async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlComment}${ApiConfig.deleteCommentEndpoint}/$commentId';

      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };

      final http.Response response = await http.delete(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Comment deleted successfully');
        return responseData;
      } else {
        throw Exception('Failed to delete comment: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to delete comment: $error');
    }
  }
}
