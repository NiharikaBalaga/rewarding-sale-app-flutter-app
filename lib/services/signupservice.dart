import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';

class SignUpApiService {
  final SecureStorageService _secureStorageService = SecureStorageService();

  Future<Map<String, dynamic>> signUp(
      String firstName, String lastName, String email) async {
    try {
      final String apiUrl =
          '${ApiConfig.baseUrlAuth}${ApiConfig.signupUserEndpoint}';
      final String? token = await _secureStorageService
          .read(SecureStorageService.keyAccessToken);

      if (token == null) {
        return {'success': false, 'error': 'Access token not found'};
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final isSignedUp = responseBody['signedUp'] as bool;
        print("User Signed up successfully: ${response.reasonPhrase}");
        return {'success': true, 'signedUp': isSignedUp};
      } else {
        print("Failed to Sign Up User: ${response.reasonPhrase}");
        return {'success': false, 'error': response.reasonPhrase};
      }
    } catch (error) {
      print("SignUpApiService Error: $error");
      return {'success': false, 'error': 'An unexpected error occurred'};
    }
  }
}
