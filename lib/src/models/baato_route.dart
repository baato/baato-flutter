import 'package:baato_api/src/models/baato_coordinate.dart';
import 'package:baato_api/src/models/baato_instruction.dart';

/// Represents a route from the Baato API
///
/// Contains details about a route including its polyline, distance, time, and navigation instructions
class BaatoRoute {
  /// The encoded polyline representation of the route
  String? encodedPolyline;

  /// The list of coordinates representing the route
  List<BaatoCoordinate>? coordinates;

  /// The total distance of the route in meters
  double? distanceInMeters;

  /// The estimated time to travel the route in milliseconds
  int? timeInMs;

  /// The list of navigation instructions for the route
  List<BaatoInstruction>? instructionList;

  /// Creates a new BaatoRoute instance
  ///
  /// [encodedPolyline] - The encoded polyline representation of the route
  /// [distanceInMeters] - The total distance of the route in meters
  /// [timeInMs] - The estimated time to travel the route in milliseconds
  /// [instructionList] - The list of navigation instructions for the route
  BaatoRoute({
    this.encodedPolyline,
    this.coordinates,
    this.distanceInMeters,
    this.timeInMs,
    this.instructionList,
  });

  /// Creates a BaatoRoute from JSON data
  ///
  /// [json] - The JSON object containing route data
  BaatoRoute.fromJson(
    Map<String, dynamic> json, {
    bool decodePolyline = false,
  }) {
    encodedPolyline = json['encodedPolyline'];
    distanceInMeters = json['distanceInMeters'];
    timeInMs = json['timeInMs'];
    if (json['instructionList'] != null) {
      instructionList = <BaatoInstruction>[];
      json['instructionList'].forEach((v) {
        instructionList?.add(new BaatoInstruction.fromJson(v));
      });
    }
    if (decodePolyline && encodedPolyline != null) {
      coordinates = decodePolylines(encodedPolyline ?? '');
    }
  }

  /// Returns a string representation of this route
  @override
  String toString() {
    return 'BaatoRoute{encodedPolyline: $encodedPolyline, distanceInMeters: $distanceInMeters, timeInMs: $timeInMs, instructionList: $instructionList}';
  }

  /// Converts this route to a JSON object
  ///
  /// Returns a Map containing the route data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encodedPolyline'] = this.encodedPolyline;
    data['distanceInMeters'] = this.distanceInMeters;
    data['timeInMs'] = this.timeInMs;
    if (this.instructionList != null) {
      data['instructionList'] =
          this.instructionList?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// Encodes a polyline string into a list of BaatoCoordinate objects
  ///
  /// Converts a Google-encoded polyline string to a list of BaatoCoordinate objects
  ///
  /// [polyline] - The Google-encoded polyline string to encode
  ///
  /// Returns a list of BaatoCoordinate objects representing the encoded polyline
  List<BaatoCoordinate> decodePolylines(String polyline) {
    List<BaatoCoordinate> poly = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      BaatoCoordinate p = BaatoCoordinate(
        (lat / 1E5).toDouble(),
        (lng / 1E5).toDouble(),
      );
      poly.add(p);
    }
    return poly;
  }
}

/// Represents a response from the Baato route API
///
/// Contains metadata about the response and a list of route results
class BaatoRouteResponse {
  /// The timestamp when the response was generated
  final String timestamp;

  /// The HTTP status code of the response
  final int status;

  /// The status message of the response
  final String message;

  /// The list of routes returned in the response
  final List<BaatoRoute>? data;

  /// Creates a new BaatoRouteResponse instance
  ///
  /// [timestamp] - The timestamp when the response was generated
  /// [status] - The HTTP status code of the response
  /// [message] - The status message of the response
  /// [data] - The list of routes returned in the response
  BaatoRouteResponse(this.timestamp, this.status, this.message, [this.data]);

  /// Creates a BaatoRouteResponse from JSON data
  ///
  /// [json] - The JSON object containing response data
  factory BaatoRouteResponse.fromJson(
    dynamic json, {
    bool decodePolyline = false,
  }) {
    var responseDataJson = json['data'] as List;
    List<BaatoRoute> _routeResults =
        responseDataJson
            .map(
              (searchJson) => BaatoRoute.fromJson(
                searchJson,
                decodePolyline: decodePolyline,
              ),
            )
            .toList();

    return BaatoRouteResponse(
      json['timestamp'] as String,
      json['status'] as int,
      json['message'] as String,
      _routeResults,
    );
  }

  /// Returns a string representation of this response
  @override
  String toString() {
    return 'BaatoRouteResponse{timestamp: $timestamp, status: $status, message: $message, data: $data}';
  }
}
