import 'package:baato_api/models/instruction.dart';

class Route {
  String encodedPolyline;
  double distanceInMeters;
  int timeInMs;
  List<Instruction> instructionList;

  Route(
      {this.encodedPolyline,
      this.distanceInMeters,
      this.timeInMs,
      this.instructionList});

  Route.fromJson(Map<String, dynamic> json) {
    encodedPolyline = json['encodedPolyline'];
    distanceInMeters = json['distanceInMeters'];
    timeInMs = json['timeInMs'];
    if (json['instructionList'] != null) {
      instructionList = new List<Instruction>();
      json['instructionList'].forEach((v) {
        instructionList.add(new Instruction.fromJson(v));
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
          this.instructionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RouteResponse {
  final String timestamp;
  final int status;
  final String message;
  final List<Route> data;

  RouteResponse(this.timestamp, this.status, this.message, [this.data]);

  factory RouteResponse.fromJson(dynamic json) {
    var responseDataJson = json['data'] as List;
    List<Route> _routeResults = responseDataJson
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
