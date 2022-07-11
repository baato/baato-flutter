import 'dart:convert';

import 'package:baato_api/models/place.dart';
import 'package:crypto/crypto.dart';

class BaatoUtils {
  String generateHash(String appId, String accessToken, String securityCode) {
    var key = utf8.encode(securityCode);
    var messageBytes = utf8.encode(appId+accessToken);

    Hmac hmac = new Hmac(sha512, key);
    Digest digest = hmac.convert(messageBytes);

    return digest.toString();
  }

  List<GeoCoord> decodeEncodedPolyline(String encoded) {
    List<GeoCoord> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      GeoCoord p = new GeoCoord((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }
}
