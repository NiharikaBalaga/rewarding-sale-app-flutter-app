class ApiConfig {

  // Auth service
  static const String baseUrlAuth = 'http://10.0.2.2:3000/api';
  static const String generateOtpEndpoint = '/auth/otp/generate';
  static const String verifyOtpEndpoint = '/auth/otp/verify';
  static const String currentUserEndpoint = '/auth/user';
  static const String userLocationEndpoint = '/auth/user/location';
  static const String refreshTokenEndpoint = '/auth/token/refresh';
  static const String signupUserEndpoint ='/auth/user/signup';
  static const String updateUserEndpoint ='/auth/user';

  // Post Service
  static const String baseUrlPost = 'http://10.0.2.2:3001/api';
  static const String getPostEndpoint = '/post/allpost';
  static const String logoutUser = '/auth/user/logout';
  static const String deletePostEndpoint ='/post';

  //Comment Service
  static const String baseUrlComment = 'http://10.0.2.2:3004/api';
  static const String addCommentEndpoint ='/comment';

  //Report Service
  static const String baseUrlReport = 'http://10.0.2.2:3007/api';
  static const String getReportEndpoint ='/report';
}