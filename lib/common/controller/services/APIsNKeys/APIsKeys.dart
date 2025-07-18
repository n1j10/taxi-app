import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:katon_taxi25/common/controller/services/APIsNKeys/keys.dart';

class APIs {
  static String geoCoadingAPI(LatLng position) =>
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapsPlatformcredential';

  static String placesAPI(String placeName) =>
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapsPlatformcredential&sessiontoken=123254251&components=country:ind';

  static String directionAPI(LatLng pickup, LatLng drop) =>
      'https://maps.googleapis.com/maps/api/directions/json?origin=${pickup.latitude},${pickup.longitude}&destination=${drop.latitude},${drop.longitude}&mode=driving&key=$mapsPlatformcredential';

  static String getLatLngFromPlaceIDAPI(String placeID) =>
      'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$mapsPlatformcredential';

  static String pushNotificationAPI() => 'https://fcm.googleapis.com/fcm/send';
}
