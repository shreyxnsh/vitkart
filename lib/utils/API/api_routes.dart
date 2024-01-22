class Domain {
  static String domain = 'api.vitkart.fun';
}

String url = 'http://${Domain.domain}/api/v1';
// String url = 'http://192.168.56.1:3001/api/v1';

String registrationUrl = '$url/user/signUp';
String loginUrl = '$url/user/signIn';
String otpVerificationUrl = '$url/emailVerification/verifyEmail';

String techProductsUrl = '$url/product/getproduct?category=tech';
String cycleProductsUrl = '$url/product/getproduct?category=cycle';
String mattressProductsUrl = '$url/product/getproduct?category=mattress';
String getAllProductUrl = '$url/product/getproduct';
String getUserProducts = '$url/product/getproduct?seller=';
String getEventsUrl = '$url/event/getEvents';
String getUserTicketsUrl = '$url/ticket/getTickets?user=';
String createProductUrl = "$url/product/createProduct?token=";
String createOrderIdUrl = "$url/razorpay/createOrderId";
String createTicketUrl = "$url/ticket/createTicket";
String updatePaymentStatusUrl = "$url/razorpay/updatePaymentStatus";
String getBannersUrl = "$url/banner/getBanners";
