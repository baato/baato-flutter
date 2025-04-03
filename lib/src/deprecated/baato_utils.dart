import 'dart:convert';

import 'package:baato_api/src/deprecated/place.dart';
import 'package:crypto/crypto.dart';

/// A utility class for Baato API operations
///
/// Provides helper methods for hash generation and polyline decoding
/// @deprecated This class is deprecated and will be removed in a future version
@deprecated
class BaatoUtils {
  /// Generates a hash for API authentication
  ///
  /// Creates a SHA-512 HMAC hash using the provided credentials
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  String generateHash(String appId, String accessToken, String securityCode) {
    var key = utf8.encode(securityCode);
    var messageBytes = utf8.encode(appId + accessToken);

    Hmac hmac = new Hmac(sha512, key);
    Digest digest = hmac.convert(messageBytes);

    return digest.toString();
  }

  /// Decodes an encoded polyline string into a list of geographic coordinates
  ///
  /// Converts a Google-encoded polyline string to a list of GeoCoord objects
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
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
