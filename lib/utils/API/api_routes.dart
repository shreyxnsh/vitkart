class Domain {
  static String domain = 'api.vitkart.fun';
  // static String domain = '192.168.64.220:3001';
}

String url = 'http://${Domain.domain}/api/v1';
// String url = 'https://peaceful-pegasus-probably.ngrok-free.app';

String registrationUrl = '$url/user/signUp';
String loginUrl = '$url/user/signIn';
String otpVerificationUrl = '$url/emailVerification/verifyEmail';

String techProductsUrl = '$url/product/getproduct?category=Technology';
String cycleProductsUrl = '$url/product/getproduct?category=Cycles';
String mattressProductsUrl = '$url/product/getproduct?category=Mattresses';
String booksProductsUrl = '$url/product/getproduct?category=Books';
String getAllProductUrl = '$url/product/getproduct';
String getUserProducts = '$url/product/getproduct?seller=';
String getEventsUrl = '$url/event/getEvents';
String getUserTicketsUrl = '$url/ticket/getTickets?user=';
String createProductUrl = "$url/product/createProduct?token=";
String createOrderIdUrl = "$url/razorpay/createOrderId";
String createTicketUrl = "$url/ticket/createTicket";
String updatePaymentStatusUrl = "$url/razorpay/updatePaymentStatus";
String getBannersUrl = "$url/banner/getBanners";
String forgetPasswordMailSendUrl = "$url/fp/passwordResetRequest";
String resetPasswordUrl = "$url/fp/resetPassword";
