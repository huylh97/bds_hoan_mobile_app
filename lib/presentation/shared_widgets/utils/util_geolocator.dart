import 'dart:convert';

import 'package:bds_hoan_mobile/data/api_service/dio_client.dart';
import 'package:geolocator/geolocator.dart';

class UtilGeolocator {
  static Future<Position?> getCurrentPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else if (permission == LocationPermission.whileInUse) {
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // static final dioClient = DioClient();

  // getAddressFromLatLng(context, double lat, double lng) async {
  //   String _host = 'https://maps.google.com/maps/api/geocode/json';
  //   final url = '$_host?key=$mapApiKey&language=en&latlng=$lat,$lng';
  //   if (lat != null && lng != null) {
  //     var response = await dioClient.get(url);
  //     if (response.statusCode == 200) {
  //       Map data = jsonDecode(response.body);
  //       String _formattedAddress = data["results"][0]["formatted_address"];
  //       print("response ==== $_formattedAddress");
  //       return _formattedAddress;
  //     } else
  //       return null;
  //   } else
  //     return null;
  // }
}
