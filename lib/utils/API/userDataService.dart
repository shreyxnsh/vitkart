
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserDataService {
  static String getUserName() {
    final storedToken = GetStorage().read('token');
    if (storedToken != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(storedToken);
      return jwtDecodedToken['userName'];
    }
    return '';
  }

  static bool isUserLoggednIn() {
    final storedToken = GetStorage().read('token');

    if (storedToken != null) {
      return !JwtDecoder.isExpired(storedToken);
    }
    return false;
  }

  static bool logoutUser() {
    final storedToken = GetStorage().read('token');
    if (storedToken != null) {
      GetStorage().remove('token');
      return true;
    }
    return false;
  }

  static String getUserEmail() {
    final storedToken = GetStorage().read('token');
    if (storedToken != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(storedToken);
      return jwtDecodedToken['userEmail'];
    }
    return '';
  }

  static String getUserID() {
    final storedToken = GetStorage().read('token');
    if (storedToken != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(storedToken);
      return jwtDecodedToken['userID'];
    }
    return '';
  }

  static String getUserBatch() {
    final storedToken = GetStorage().read('token');
    if (storedToken != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(storedToken);
      return jwtDecodedToken['userBatch'];
    }
    return '';
  }

  static String getUserBirthDate() {
    final storedToken = GetStorage().read('token');
    if (storedToken != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(storedToken);
      return jwtDecodedToken['userBirthDate'];
    }
    return '';
  }

  static String getUserRegID() {
    final storedToken = GetStorage().read('token');
    if (storedToken != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(storedToken);
      return jwtDecodedToken['userRegID'];
    }
    return '';
  }

  static String getUserGender() {
    final storedToken = GetStorage().read('token');
    if (storedToken != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(storedToken);
      return jwtDecodedToken['userGender'];
    }
    return '';
  }

  // Add more functions for additional user data fields as needed
}
