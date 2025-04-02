import 'package:baato_api/src/models/baato_coordinate.dart';

/// A class representing a place from the Baato API.
///
/// Contains information about a geographic location including its coordinates,
/// name, address, and other metadata.
class BaatoPlace {
  /// Unique identifier for the place.
  final int placeId;

  /// Baato-specific identifier for the place.
  final int baatoId;

  /// License information for the place data.
  final String license;

  /// Relevance score for the place (higher is more relevant).
  final double score;

  /// Formatted address of the place.
  final String address;

  /// Centroid coordinates of the place.
  final BaatoCoordinate centroid;

  /// Name of the place.
  final String name;

  /// Geometric representation of the place.
  final Geometry geometry;

  /// Type of the place (e.g., "restaurant", "school", etc.).
  final String type;

  /// List of tags associated with the place.
  final List<String> tags;

  /// Creates a new [BaatoPlace] instance.
  BaatoPlace(
    this.placeId,
    this.baatoId,
    this.name,
    this.address,
    this.score,
    this.type,
    this.license,
    this.centroid,
    this.geometry,
    this.tags,
  );

  /// Creates a [BaatoPlace] from a JSON object.
  factory BaatoPlace.fromJson(dynamic json) {
    final score = double.tryParse(json['score'].toString()) ?? 0.0;
    return BaatoPlace(
      json['placeId'] as int,
      json['osmId'] as int,
      json['name'] as String,
      json['address'] as String,
      score,
      json['type'] as String,
      json['license'] as String,
      BaatoCoordinate.fromJson(json['centroid']),
      Geometry.fromJson(json['geometry']),
      json['tags'].cast<String>(),
    );
  }

  @override
  String toString() {
    return 'BaatoPlace{license: $license, score: $score, address: $address, centroid: $centroid, placeId: $placeId, name: $name, geometry: $geometry, type: $type, tags: $tags}';
  }
}

/// Response object for place search queries from the Baato API.
class BaatoPlaceResponse {
  /// Timestamp of when the response was generated.
  final String timestamp;

  /// HTTP status code of the response.
  final int status;

  /// Response message.
  final String message;

  /// List of places returned in the response.
  final List<BaatoPlace>? data;

  /// Creates a new [BaatoPlaceResponse] instance.
  BaatoPlaceResponse(this.timestamp, this.status, this.message, [this.data]);

  /// Creates a [BaatoPlaceResponse] from a JSON object.
  factory BaatoPlaceResponse.fromJson(dynamic json) {
    var responseDataJson = json['data'] as List;
    List<BaatoPlace> _placeResults =
        responseDataJson
            .map((searchJson) => BaatoPlace.fromJson(searchJson))
            .toList();

    return BaatoPlaceResponse(
      json['timestamp'] as String,
      json['status'] as int,
      json['message'] as String,
      _placeResults,
    );
  }

  @override
  String toString() {
    return 'BaatoPlaceResponse{timestamp: $timestamp, status: $status, message: $message, data: $data}';
  }
}

/// Represents the geometric shape of a place.
class Geometry {
  /// Type of geometry (e.g., "Point", "Polygon", etc.).
  final String type;

  /// Coordinates defining the geometry.
  final Object coordinates;

  /// Creates a new [Geometry] instance.
  Geometry(this.type, this.coordinates);

  /// Creates a [Geometry] from a JSON object.
  factory Geometry.fromJson(dynamic json) {
    return Geometry(json['type'] as String, json['coordinates'] as Object);
  }

  @override
  String toString() {
    return 'Geometry{type: $type, coordinates: $coordinates}';
  }
}

/// Represents a geographic coordinate with latitude and longitude.
class GeoCoord {
  /// Latitude in degrees.
  final double lat;

  /// Longitude in degrees.
  final double lon;

  /// Creates a new [GeoCoord] instance.
  GeoCoord(this.lat, this.lon);

  /// Creates a [GeoCoord] from a JSON object.
  factory GeoCoord.fromJson(dynamic json) {
    return GeoCoord(json['lat'] as double, json['lon'] as double);
  }

  @override
  String toString() {
    return 'GeoCoord{lat: $lat, lon: $lon}';
  }
}
