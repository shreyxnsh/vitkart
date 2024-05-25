enum Domain {
  LOCAL,
  PRODUCTION,
  DEVELOPMENT;

  // return string on using any enum
}

// Map enum
Map<Domain, String> domainMap = {
  Domain.LOCAL: '192.168.31.102:3000',
  Domain.PRODUCTION: 'api.vitkart.fun',
  Domain.DEVELOPMENT:
      '5c51-2409-40c4-1175-a732-1de1-3163-9608-d049.ngrok-free.app'
};

String url = 'http://${domainMap[Domain.LOCAL]}/api/v1';
// String url = 'https://peaceful-pegasus-probably.ngrok-free.app';

String registrationUrl = '$url/user/signUp';
String loginUrl = '$url/user/signIn';
String resentOtp = '$url/user/resendOTPonSignUp';
String otpVerificationUrl = '$url/emailVerification/verifyEmail';

String techProductsUrl = '$url/product/getproduct?category=Technology';
String cycleProductsUrl = '$url/product/getproduct?category=Cycles';
String mattressProductsUrl = '$url/product/getproduct?category=Mattresses';
String booksProductsUrl = '$url/product/getproduct?category=Books';
String getAllProductUrl = '$url/product/getproduct';
String getUserProducts = '$url/product/getproduct?sellerId=';
String getMyProductsUrl = '$url/product/getproduct?buyerId=';
String getMyBidsUrl = '$url/product/getproduct?bidderId=';
String placeBidUrl = "$url/product/placebid";
String cancelBidUrl = "$url/product/cancelBid";
String approveBitUrl = "$url/product/acceptBid";
String removeBidUrl = "$url/product/removeBid";
String getBiddersListUrl = "$url/product/getProductBids?productId=";
String getEventsUrl = '$url/event/getEvents';
String getUserTicketsUrl = '$url/ticket/getTickets?user=';
String createProductUrl = "$url/product/createProduct?token=";
String createOrderIdUrl = "$url/razorpay/createOrderId";
String createTicketUrl = "$url/ticket/createTicket";
String updatePaymentStatusUrl = "$url/razorpay/updatePaymentStatus";
String getBannersUrl = "$url/banner/getBanners";

String requestForgetPassUrl = "$url/fp/passwordResetRequest";
String verifyOtpUrl = "$url/otp/verifyAccount";
String newPasswordUrl = "$url/fp/resetPassword";
