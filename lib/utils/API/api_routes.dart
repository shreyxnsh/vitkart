// 192.168.56.1


// const String domain = 'http://192.168.56.1:3001';


const String domain =
    'https://36f1-2405-201-682b-707a-b365-6158-77dd-e5df.ngrok-free.app';






const url = '$domain/api/v1';
const registrationUrl = '$url/user/createNewAccount';
const loginUrl = '$url/user/signIn';
const otpVerificationUrl = '$url/emailVerification/verifyEmail';

const techProductsUrl = '$url/product/getproduct?category=tech';
const cycleProductsUrl = '$url/product/getproduct?category=cycle';
const mattressProductsUrl = '$url/product/getproduct?category=mattress';
const getAllProductUrl = '$url/product/getproduct';
const getUserProducts = '$url/product/getproduct?seller=';

const createProductUrl = "$url/product/createProduct?token=";