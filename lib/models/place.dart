class Place {
  final String license;
  final Object score;
  final String address;
  final GeoCoord centroid;
  final int placeId;
  final String name;
  final Geometry geometry;
  final String type;
  final List<String> tags;

  Place(this.placeId, this.name, this.address, this.score, this.type,
      this.license, this.centroid, this.geometry, this.tags);

  factory Place.fromJson(dynamic json) {
    // var tagsJson = json['tags'] as List;
    // List<String> _tags ;
    // = tagsJson.map((e) => e).toList();
    return Place(
        json['placeId'] as int,
        json['name'] as String,
        json['address'] as String,
        json['score'] as Object,
        json['type'] as String,
        json['license'] as String,
        GeoCoord.fromJson(json['centroid']),
        Geometry.fromJson(json['geometry']),
        json['tags'].cast<String>());
  }

  @override
  String toString() {
    return 'Place{license: $license, score: $score, address: $address, centroid: $centroid, placeId: $placeId, name: $name, geometry: $geometry, type: $type, tags: $tags}';
  }
}

class PlaceResponse {
  final String timestamp;
  final int status;
  final String message;
  final List<Place>? data;

  PlaceResponse(this.timestamp, this.status, this.message, [this.data]);

  factory PlaceResponse.fromJson(dynamic json) {
    var responseDataJson = json['data'] as List;
    List<Place> _placeResults = responseDataJson
        .map((searchJson) => Place.fromJson(searchJson))
        .toList();

    return PlaceResponse(
      json['timestamp'] as String,
      json['status'] as int,
      json['message'] as String,
      _placeResults,
    );
  }

  @override
  String toString() {
    return 'PlaceResponse{timestamp: $timestamp, status: $status, message: $message, data: $data}';
  }
}

class Geometry {
  final String type;
  final Object coordinates;

  Geometry(this.type, this.coordinates);

  factory Geometry.fromJson(dynamic json) {
    return Geometry(json['type'] as String, json['coordinates'] as Object);
  }

  @override
  String toString() {
    return 'Geometry{type: $type, coordinates: $coordinates}';
  }
}

class GeoCoord {
  final double lat, lon;

  GeoCoord(this.lat, this.lon);

  factory GeoCoord.fromJson(dynamic json) {
    return GeoCoord(json['lat'] as double, json['lon'] as double);
  }

  @override
  String toString() {
    return 'GeoCoord{lat: $lat, lon: $lon}';
  }
}
