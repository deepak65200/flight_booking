import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // Base (conceptual – not used for assets)
 // static const String baseUrl = "https://api.flightbooking.com";
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  static final String imageBaseUrl = dotenv.env['IMAGE_BASE_URL'] ?? '';

  // Endpoints (SIMULATED)
  static const String airports = "/airports";
  static const String searchFlights = "/flights/search";
  static const String flightDetails = "/flights";
}


// class ApiConstants {
//   static final String baseUrl = dotenv.env['BASE_URL'] ?? '';
//   static final String imageBaseUrl = dotenv.env['IMAGE_BASE_URL'] ?? '';
//   //sign up
//   static const String signupSendOtp = '/user/signup-send-otp';
//   static const String signupVerifyOtp = '/user/signup-verify-otp';
//   static const String signUp = '/user/signup';
//   static const String forgotPassword = '/user/forgot-password';
//   static const String forgotOtpVerify = '/user/forgot-otp-verify';
//   static const String forgotResetPass = '/user/forgot-reset-password';
//
//   //login
//   static const String login = '/user/login';
//   static const String loginVerifyOtp = '/user/verify-otp';
//   static const String socialLogin = '/user/social/login';
//   static const String appleLogin = '/user/apple/login';
//
//   //profile
//   static const String getProfile = '/user/get-profile';
//   static const String getLanguage = '/user/get-language';
//   static const String updateProfile = '/user/update-profile';
//   static const String updateLegalName = '/user/update-legal-name';
//   static const String updatePreName = '/user/update-preferred-name';
//
//   static const String changeReqMob = '/user/change-request-mobile';
//   static const String changeReqMobVerifyOTP = '/user/change-request-mobile-verify-otp';
//   static const String updateNewMobSendOTP = '/user/update-new-mobile-send-otp';
//   static const String updateNewMobVerifyOTP = '/user/update-mobile-number';
//
//   static const String changeReqEmail = '/user/change-request-email';
//   static const String changeReqEmailVerifyOTP = '/user/change-request-email-verify-otp';
//   static const String changeReqEmailSendOTP = '/user/update-new-email-send-otp';
//   static const String updateEmailVerifyOtp = '/user/update-email';
//
//   static const String updateAddress = '/user/update-address';
//   static const String updateEmergency = '/user/update-emergency';
//   static const String changePassword = '/user/change-password';
//
//   static const String deleteProfile = '/user/delete-profile';
//   static const String deleteProVerifyOtp = '/user/delete-profile-verify-otp';
//   static const String userGetBankInf = '/user/get-bank-info';
//   static const String userUpdateBankInf = '/user/update-bank-info';
//   static const String hostEarningList = '/user/host-earning-list';
//   static const String hostPayoutList = '/user/host-payout-list';
//   static const String hostEarningPdf = 'user/host-earning-pdf';
//   static const String hostPayoutPdf = 'user/host-payout-pdf';
//
//   //home
//   static const String mostPopular = '/user/most-popular-property';
//   static const String getOverAllProList = '/user/overall-property';
//   static const String propertyDetails= '/user/property-details';
//   static const String getReportReason = '/user/get-report-reason';
//   static const String reportProperty= '/user/report-property';
//   static const String applyPromoCode = '/user/apply-promo-code';
//   static const String userCheckAvailability = '/user/checkAvailability';
//   static const String userProCA = '/user/propertyCalendarAvailability';
//
//   //rating
//   static const String storeOrderRating = '/user/store-order-rating';
//   static const String getHostRR = '/user/get-host-rating-review';
//   static const String getPropertyRR = '/user/get-property-rating-review';
//   static const String reqDeleteRating = '/user/request-to-delete-rating';
//
//   //complaint
//   static const String complaintByGuest = '/user/complaint-by-guest';
//   static const String getComplaintForGuest = '/user/get-complaint-for-guest';
//   static const String updateComplaintByHost = '/user/update-complaint-by-host';
//   static const String getComplaintForHost = '/user/get-complaint-for-host';
//
//   //notification
//   static const String notificationList = '/user/notification-list';
//   static const String notificationUpdate = '/user/notification-update';
//   //master
//   static const String banner = '/user/get-banner';
//   static const String termCondition = '/user/get-term-and-condition';
//   static const String privacyPolicy = '/user/get-privacy-policy';
//   static const String aboutUs = '/user/get-about-us';
//   static const String faq = '/user/get-faq';
//   static const String helpSetting = '/user/get-setting';
//   static const String cancellationPolicy = '/user/get-cancellation-policy';
//   //host Document
//   static const String getManDocHost= '/user/get-mandatory-doc-for-host';
//   static const String userGetDocStatus = '/user/get-document-status';
//   static const String userGetUploadedDoc = '/user/get-upload-document';
//   static const String userUploadDoc = '/user/upload-document';
//   //host module
//   static const String hostPropertyList = '/user/property/list';
//   static const String hostPropertyStatus = '/user/property/status/change';
//   static const String hostStoreProperty = '/user/property/store';
//   static const String propertyDeleteReason = '/user/get-delete-property-reason';
//   static const String propertyDelete = '/user/property/delete';
//   static const String hostPropertyCalender = '/user/host-property-calendar';
//   static const String hostProPropertyDeletePhoto = '/user/property/delete-photo';
//   // host property Update
//
//   static const String hostUpdateBasicInfo= '/user/property/update-basic-info';
//   static const String hostUpdateTypeofPro= '/user/property/update-type-of-property';
//   static const String hostUpdateProAddress= '/user/property/update-property-address';
//   static const String hostUpdateGuestFit= '/user/property/update-guest-fit';
//   static const String hostUpdateDateTimePrice= '/user/property/update-property-price';
//   static const String hostUpdateRulePolicy= '/user/property/update-property-rule';
//
//   //host message
//   static const String getMessageHost = '/user/get-message-for-host';
//   static const String sendMessageHost = '/user/send-message-for-host';
//   static const String userMessageBoardHost = '/user/message-board-for-host';
//   //guest message
//   static const String getMessageGuest = '/user/get-message-for-guest';
//   static const String sendMessageGuest = '/user/send-message-for-guest';
//   static const String userMessageBoardGuest = '/user/message-board-for-guest';
//
//   static const String storeRecentView = '/user/store-recent-view';
//   static const String userRecentView = '/user/recent-view-list';
//   static const String deleteRecentView = '/user/delete-recent-view';
//   static const String clearRecentView = '/user/clear-recent-view';
//
//   static const String storeWishlist = '/user/store-wishlist';
//   static const String userWishlist = '/user/wishlist';
//   static const String userDeleteWishlist = '/user/delete-wishlist';
//   static const String userClearWishlist = '/user/clear-wishlist';
//
//   static const String getPropertyType = '/user/get-property-type';
//   static const String getBedType = '/user/get-bed-type';
//   static const String getAmenity = '/user/get-amenity';
//   static const String getPhotoCat = '/user/get-photo-category';
//   static const String getProPlaceHigh = '/user/get-place-highlight';
//   static const String getHouseRule = '/user/get-house-rule';
//   static const String getCancelReason = '/user/get-cancel-reason';
//   static const String getComplaintType = '/user/get-complaint-type';
//
//   // for razorpay
//   static const String createPaymentIntent = '/user/plan-payment-intent';
//   static const String paymentSuccess = '/user/plan-payment-success';
//
//   static const String createOrderIntent = '/user/order-intent';
//   static const String orderComplete = '/user/order-complete';
//   static const String requestPaymentDetails = '/xp021/v1/request/details?requestId=';
//
//   static const String guestOrderList = '/user/guest-order-list';
//   static const String guestOrderDetails = '/user/guest-order-details';
//   static const String guestOrderCancel = '/user/cancel-order-by-guest';
//   static const String hostOrderList = '/user/host-order-list';
//   static const String hostOrderDetails = '/user/host-order-details';
//   static const String guestInf = '/user/guest-information';
//   static const String hostInf = '/user/host-information';
//   static const String checkIn = '/user/checkIn';
//   static const String checkOut = '/user/checkOut';
//
// }
