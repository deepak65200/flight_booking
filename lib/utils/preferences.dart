import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const userToken = 'user_token';
  static const deviceToken = 'device_token';
  static const userId = 'user_id';
  static const userCompReg = 'complete_register';
  static const isFinishOnBoardingKey = 'is_FinishOnBoardingKey';
  static const userLoggedIn = 'user_logged_in';
  static const userRole = 'user_role';
  static const uniqueId = "unique_id";
  static const firstName = "first_name";
  static const lastName = "last_name";
  static const userMobile = 'mobile';
  static const userEmail = "email";
  static const dob = "dob";
  static const address = "address";
  static const country = "country";
  static const city = "city";
  static const landmark = "landmark";
  static const about = "about";
  static const speakLanguage = "speak_language";
  static const occupation = "occupation";
  static const profileImage = "profile_image";

  static const userProfileImage = 'profile_image';
  static const userCityID = 'city_id';
  static const userCityName = 'city_name';
  static const userRC = 'my_referral_code';

  static const userStreetNum = "street_number";
  static const userStreetName = "street_name";
  static const userLocality = "locality";
  static const userSubLocality = "sub_locality";
  static const userState = "state";
  static const userDistrict = "district";
  static const userCountry = "country";
  static const userPostalCode = "postal_code";
  static const userPinCode = 'pin_code';
  static const userAddress = "address";
  static const mCurrentLat = "current_lat";
  static const mCurrentLng = "current_long";
  static const mCountryISOCode = "countryISOCode";

  static late SharedPreferences pref;

  static initPref() async {
    pref = await SharedPreferences.getInstance();
  }

  static bool getBoolean(String key) {
    return pref.getBool(key) ?? false;
  }

  static Future<void> setBoolean(String key, bool value) async {
    await pref.setBool(key, value);
  }

  static String getString(String key, {String? defaultValue}) {
    return pref.getString(key) ?? defaultValue ?? "";
  }

  static Future<void> setString(String key, String value) async {
    await pref.setString(key, value);
  }

  static int getInt(String key) {
    return pref.getInt(key) ?? 0;
  }

  static Future<void> setInt(String key, int value) async {
    await pref.setInt(key, value);
  }
  static Future<void> setStringList(String key, List<String> value) async {
    await pref.setStringList(key, value);
  }

  static List<String> getStringList(String key) {
    return pref.getStringList(key) ?? [];
  }

  static Future<void> clearSharPreference() async {
    await pref.clear();
  }

  static Future<void> clearKeyData(String key) async {
    await pref.remove(key);
  }

  static bool isLoggedIn() {
    return Preferences.getBoolean(Preferences.userLoggedIn) ?? false;
  }
}
