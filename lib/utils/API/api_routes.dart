const url = 'http://192.168.29.118:3001/api/v1';
// const url = 'http://192.168.56.1:3001/api/v1';

const registrationUrl = '$url/user/createNewAccount';
const loginUrl = '$url/user/signIn';
const otpVerificationUrl = '$url/emailVerification/verifyEmail';

const techProductsUrl = '$url/product/getproduct?category=tech';
const cycleProductsUrl = '$url/product/getproduct?category=cycle';
const mattressProductsUrl = '$url/product/getproduct?category=mattress';
const getAllProductUrl = '$url/product/getproduct';
const getUserProducts = '$url/product/getproduct?seller=';

const createProductUrl = "$url/product/createProduct?token=";
