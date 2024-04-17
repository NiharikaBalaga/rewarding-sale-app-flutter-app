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
  static const String getPostId = '/post';

  //Comment Service
  static const String baseUrlComment = 'http://10.0.2.2:3004/api';
  static const String addCommentEndpoint ='/comment';
  static const String getCommentEndpoint ='/comment/comments';
  static const String editCommentEndpoint ='/comment';
  static const String deleteCommentEndpoint ='/comment';

  //Report Service
  static const String baseUrlReport = 'http://10.0.2.2:3007/api';
  static const String getReportEndpoint ='/report';

  //Rewards Service
  static const String baseUrlRewards = 'http://10.0.2.2:3006/api';
  static const String getRewardsEndpoint ='/rewards/user/points';

  //Vote Service
  static const String baseUrlVote = 'http://10.0.2.2:3005/api';
  static const String patchVoteEndpoint ='/vote';

  //search service
  static const String baseUrlSearch = 'http://10.0.2.2:3003/api';
  static const String getSearchEndpoint ='/search';
}