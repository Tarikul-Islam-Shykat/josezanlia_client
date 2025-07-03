class Urls {
  static const String baseUrl = 'https://josezanlia-backend.vercel.app/api/v1';
  static const String login = '$baseUrl/auth/login';
  static const String resendOTP = "$baseUrl/auth/resend-otp";
  static const String verifyOTP = "$baseUrl/auth/verify-otp";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String getMe = "$baseUrl/auth/profile";
  static const String updateProfile = "$baseUrl/users/consumer"; //PUT with id
  static const String signUp = '$baseUrl/users/register';
  static const String setupProfile = '$baseUrl/users/update-profile';
  static const String authentication = '$baseUrl/auth/verify-auth';
  static const String logout = '$baseUrl/auth/logout';
  static const String sendOTPForgot = '$baseUrl/auth/forgot-password';
  static const String changePass = '$baseUrl/auth/change-password';
  static const String pickUpLocation = '$baseUrl/user/pickup-locations';
  static String getCalendar(String date, String locationUuid) =>
      '$baseUrl/calendar?date=$date&pickup_location_uuid=$locationUuid';
  static const String getMonthlyReport =
      '$baseUrl/readings/consumer/yearly-readings';

  static const String history = '$baseUrl/readings/consumer/payment-history';
  static const String policy = '$baseUrl/policy';
  static const String guidelines = '$baseUrl/guideline';

  static const String getConsumerReading = "$baseUrl/readings/consumer/allReadings";//GET ID
  static const String getNotifications = "$baseUrl/notifications";//GET
  static const String readNotifications = "$baseUrl/notifications/read";//PATCH
}
