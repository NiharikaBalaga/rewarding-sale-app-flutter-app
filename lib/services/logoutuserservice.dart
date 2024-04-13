// import 'package:http/http.dart' as http;
// import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
// import '../config/apiconfig.dart';
//
// class LogoutApiService {
//   final SecureStorageService _secureStorageService = SecureStorageService();
//
//   Future<bool> logout() async {
//     try {
//       final String apiUrl =
//           '${ApiConfig.baseUrlAuth}${ApiConfig.logoutUserEndpoint}';
//       final String? token = await _secureStorageService
//           .read(SecureStorageService.keyAccessToken);
//
//       if (token == null) {
//         print('Access token not found');
//         return false;
//       }
//
//       final response = await http.get(
//         Uri.parse(apiUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         // Clear token from storage or perform any other cleanup if needed
//         await _secureStorageService.delete(SecureStorageService.keyAccessToken);
//         print('Logout successful');
//         return true;
//       } else {
//         print('Failed to logout: ${response.reasonPhrase}');
//         return false;
//       }
//     } catch (error) {
//       print('Logout error: $error');
//       return false;
//     }
//   }
// }
