import 'dart:convert';

import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';

import '../Enums/httpenums.dart';
import '../config/apiconfig.dart';
import '../helpers/httpclient.dart';

class VerifyOtpApiService {
  final SecureStorageService secureStorageService = SecureStorageService();

  Future<Map<String, dynamic>> verifyOtp(String phoneNumber, String otp) async {
    try {
      Map<String, dynamic> load = {
        'phoneNumber': phoneNumber,
        'otp': otp,
      };
      final payload = jsonEncode(load);
      final response = await HttpClient.sendRequest(
        HttpMethod.POST,
        payload,
        '${ApiConfig.baseUrlAuth}${ApiConfig.verifyOtpEndpoint}',
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['accessToken'] as String;
        final refreshToken = responseBody['refreshToken'] as String;
        await secureStorageService.write(
            SecureStorageService.keyAccessToken, accessToken);
        await secureStorageService.write(
            SecureStorageService.keyRefreshToken, refreshToken);
        final isSignedUp = responseBody['isSignedUp'] as bool;

        return {'success': true, 'isSignedUp': isSignedUp};
      } else {
        print("Failed to Verify OTP: ${response.reasonPhrase}");
        return {'success': false, 'isSignedUp': false};
        ;
      }
    } catch (error) {
      print("verifyOtp----$error");
      return {'success': false, 'isSignedUp': false};
      ;
    }
  }
}
