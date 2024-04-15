import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';

class VoteService {
  static Future<void> voteForPost(String postId) async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlVote}${ApiConfig.patchVoteEndpoint}/$postId/vote';

      // Instantiate SecureStorageService
      final secureStorageService = SecureStorageService();

      // Read access token from secure storage
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      // Make HTTP PATCH request with authorization header
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Include authorization header
        },
      );

      if (response.statusCode == 200) {
        // Vote successful
        print('Voted for post with ID: $postId');
      } else {
        throw Exception('Failed to vote for post: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to vote for post: $error');
    }
  }
}
