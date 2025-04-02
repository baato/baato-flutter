import 'package:baato_api/src/deprecated/instruction.dart';

/// @deprecated This class is deprecated and will be removed in a future version.
/// Please use the newer models in the main package instead.
@deprecated
class Route {
  String? encodedPolyline;
  double? distanceInMeters;
  int? timeInMs;
  List<Instruction>? instructionList;

  /// @deprecated This constructor is deprecated and will be removed in a future version.
  @deprecated
  Route({
    this.encodedPolyline,
    this.distanceInMeters,
    this.timeInMs,
    this.instructionList,
  });

  /// @deprecated This factory is deprecated and will be removed in a future version.
  @deprecated
  Route.fromJson(Map<String, dynamic> json) {
    encodedPolyline = json['encodedPolyline'];
    distanceInMeters = json['distanceInMeters'];
    timeInMs = json['timeInMs'];
    if (json['instructionList'] != null) {
      instructionList = <Instruction>[];
      json['instructionList'].forEach((v) {
        instructionList?.add(new Instruction.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'Route{encodedPolyline: $encodedPolyline, distanceInMeters: $distanceInMeters, timeInMs: $timeInMs, instructionList: $instructionList}';
  }

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

/// @deprecated This class is deprecated and will be removed in a future version.
/// Please use the newer models in the main package instead.
@deprecated
class RouteResponse {
  final String timestamp;
  final int status;
  final String message;
  final List<Route>? data;

  /// @deprecated This constructor is deprecated and will be removed in a future version.
  @deprecated
  RouteResponse(this.timestamp, this.status, this.message, [this.data]);

  /// @deprecated This factory is deprecated and will be removed in a future version.
  @deprecated
  factory RouteResponse.fromJson(dynamic json) {
    var responseDataJson = json['data'] as List;
    List<Route> _routeResults =
        responseDataJson
            .map((searchJson) => Route.fromJson(searchJson))
            .toList();

    return RouteResponse(
      json['timestamp'] as String,
      json['status'] as int,
      json['message'] as String,
      _routeResults,
    );
  }

  @override
  String toString() {
    return 'RouteResponse{timestamp: $timestamp, status: $status, message: $message, data: $data}';
  }
}
