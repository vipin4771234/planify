// BaseUrl
// const String baseUrl = "https://api.planify.holiday/v1";
const String baseUrl = "https://api.planify.holiday/api";
// const String baseUrl = "http://192.168.43.138:3000/api";

/// Auth
const String loginApiUrl = "$baseUrl/user/login";
const String registerApiUrl = "$baseUrl/user/register";
const String forgotPasswordApiUrl = "$baseUrl/user/forgot-password";
const String verifyOTPApiUrl = "$baseUrl/user/forgot-password/verify/otp";
const String addNewPasswordApiUrl =
    "$baseUrl/user/forgot-password/add-new-password";
const String updateUserProfileApiUrl = "$baseUrl/user/updateUserProfile";
const String logoutApiUrl = "$baseUrl/user/logout";
const String deleteUserApiUrl = "$baseUrl/user/deleteAccount";

/// Notification
const String allNotificationApiUrl = "$baseUrl/notifications";
const String myNotificationApiUrl = "$baseUrl/notifications/my";

/// Trip
const String getAllPublicTripApiUrl = "$baseUrl/trip/getAllTripPublic";
const String getTripStatsApiUrl = "$baseUrl/stats";
const String getTripDetailByIdApiUrl = "$baseUrl/trip/getTripDetail";
const String createTripApiUrl = "$baseUrl/trip/createNewTrip";
const String getMySavedTripApiUrl = "$baseUrl/trip/getMySavedTrips";
const String getMyTripApiUrl = "$baseUrl/trip/getMyTrips";
const String markTripFavoriteApiUrl = "$baseUrl/trip/saveTrip";
const String rateTripApiUrl = "$baseUrl/trip/rateTrip";
const String tripShareTripApiUrl = "$baseUrl/trip/shareTrip";
const String getTripInfoApiUrl = "$baseUrl/trip/getTripInfo";

const String previousIterationTripApiUrl =
    "$baseUrl/trip/tipItinerary/previous";
const String regenerateTripApiUrl = "$baseUrl/trip/tipItinerary/regenarate";
const String reuseTripApiUrl = "$baseUrl/trip/tipItinerary/reuse";

const String giftCodeGeneratorApiUrl = "$baseUrl/trip/giftCodeGenerator";
const String radeemGiftCodeApiUrl = "$baseUrl/trip/redeem";
const String availableTripsCountApiUrl = "$baseUrl/trip/availableTripsCount";
const String refreshTripInfoApiUrl = "$baseUrl/trip/getTripInfo";

/// Subscriptions
const String getMySubscriptionApiUrl =
    "$baseUrl/subscription/getMySubscription";

const String makeSubscriptionApiUrl = "$baseUrl/subscription/saveSubscription";

/// Misc
const String getFaqDetailApiUrl = "$baseUrl/misc/faq";
const String userSupportContactApiUrl = "$baseUrl/support/contact";
const String postSupportApiUrl = "$baseUrl/misc/support";

/// Get All Continents
const String getAllCountriesApiUrl = "$baseUrl/country/getCountries";
const String getAllContinentsApiUrl = "$baseUrl/country/getContinents";
const String getCountryByContinentApiUrl =
    "$baseUrl/country/getCountriesByContinent/";

// const String getProvinceApiUrl = "$baseUrl/api/lookups/GetProvinces";
