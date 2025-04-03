import 'package:baato_api/src/models/baato_instruction.dart';

/// Represents a route from the Baato API
///
/// Contains details about a route including its polyline, distance, time, and navigation instructions
class BaatoRoute {
  /// The encoded polyline representation of the route
  String? encodedPolyline;

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
    this.distanceInMeters,
    this.timeInMs,
    this.instructionList,
  });

  /// Creates a BaatoRoute from JSON data
  ///
  /// [json] - The JSON object containing route data
  BaatoRoute.fromJson(Map<String, dynamic> json) {
    encodedPolyline = json['encodedPolyline'];
    distanceInMeters = json['distanceInMeters'];
    timeInMs = json['timeInMs'];
    if (json['instructionList'] != null) {
      instructionList = <BaatoInstruction>[];
      json['instructionList'].forEach((v) {
        instructionList?.add(new BaatoInstruction.fromJson(v));
      });
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
  factory BaatoRouteResponse.fromJson(dynamic json) {
    var responseDataJson = json['data'] as List;
    List<BaatoRoute> _routeResults =
        responseDataJson
            .map((searchJson) => BaatoRoute.fromJson(searchJson))
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
