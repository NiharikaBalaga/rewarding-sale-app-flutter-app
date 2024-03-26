// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
// // import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
// // import '../config/apiconfig.dart';
// //
// // class CurrentUserService {
// //   static Future<List<Post>> getCurrentUser() async {
// //     try {
// //       final String apiUrl = '${ApiConfig.baseUrlAuth}${ApiConfig.currentUserEndpoint}';
// //       final secureStorageService = SecureStorageService();
// //       final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);
// //
// //       if (accessToken == null) {
// //         throw Exception('Access token not available');
// //       }
// //
// //       final response = await http.get(
// //           Uri.parse(apiUrl),
// //           headers: {
// //             'Authorization': 'Bearer $accessToken', // Include authorization header
// //           }
// //       );
// //
// //       if (response.statusCode == 200) {
// //         final List<dynamic> responseData = json.decode(response.body)['data'];
// //         return responseData.map<Post>((json) => Post.fromJson(json)).toList();
// //       } else {
// //         throw Exception('Failed to load user: ${response.statusCode}');
// //       }
// //     } catch (error) {
// //       throw Exception('Failed to load user: $error');
// //     }
// //   }
// // }
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:rewarding_sale_app_flutter_app/models/CurrentUser.dart'; // Import the User model
// import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
// import '../config/apiconfig.dart';
//
// class CurrentUserService {
//   static Future<CurrentUser> getCurrentUser() async {
//     try {
//       final String apiUrl = '${ApiConfig.baseUrlAuth}${ApiConfig.currentUserEndpoint}';
//       final secureStorageService = SecureStorageService();
//       final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);
//
//       if (accessToken == null) {
//         throw Exception('Access token not available');
//       }
//
//       final response = await http.get(
//         Uri.parse(apiUrl),
//         headers: {
//           'Authorization': 'Bearer $accessToken', // Include authorization header
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         return CurrentUser.fromJson(responseData); // Convert JSON data to User object
//       } else {
//         throw Exception('Failed to load user: ${response.statusCode}');
//       }
//     } catch (error) {
//       throw Exception('Failed to load user: $error');
//     }
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/models/CurrentUser.dart'; // Import the User model
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';

class CurrentUserService {
  static Future<CurrentUser> getCurrentUser() async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlAuth}${ApiConfig.currentUserEndpoint}';
      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken', // Include authorization header
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return CurrentUser.fromJson(responseData); // Convert JSON data to User object
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load user: $error');
    }
  }
}
