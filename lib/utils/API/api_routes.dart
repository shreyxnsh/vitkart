class Domain {
  static String domain = '192.168.29.118';
}

String url = 'http://${Domain.domain}:3001/api/v1';
// String url = 'http://192.168.56.1:3001/api/v1';

String registrationUrl = '$url/user/createNewAccount';
String loginUrl = '$url/user/signIn';
String otpVerificationUrl = '$url/emailVerification/verifyEmail';

String techProductsUrl = '$url/product/getproduct?category=tech';
String cycleProductsUrl = '$url/product/getproduct?category=cycle';
String mattressProductsUrl = '$url/product/getproduct?category=mattress';
String getAllProductUrl = '$url/product/getproduct';
String getUserProducts = '$url/product/getproduct?seller=';
String getEventsUrl = '$url/event/getEvents';
String createProductUrl = "$url/product/createProduct?token=";
String createOrderIdUrl = "$url/razorpay/createOrderId";
String createTicketUrl = "$url/ticket/createTicket";
