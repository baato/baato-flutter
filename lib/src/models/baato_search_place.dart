/// Represents a search result place from the Baato API
///
/// Contains details about a place including its ID, name, address, and other attributes
class BaatoSearchPlace {
  /// The unique identifier for the place
  final int placeId;

  /// The Baato-specific identifier for the place
  final int baatoId;

  /// The name of the place
  final String name;

  /// The formatted address of the place
  final String address;

  /// The relevance score of the search result
  final double score;

  /// The type or category of the place
  final String type;

  /// The distance from the search center in kilometers
  final double radialDistanceInKm;

  /// Creates a new BaatoSearchPlace instance
  ///
  /// [placeId] - The unique identifier for the place
  /// [baatoId] - The Baato-specific identifier for the place
  /// [name] - The name of the place
  /// [address] - The formatted address of the place
  /// [score] - The relevance score of the search result
  /// [type] - The type or category of the place
  /// [radialDistanceInKm] - The distance from the search center in kilometers
  BaatoSearchPlace(
    this.placeId,
    this.baatoId,
    this.name,
    this.address,
    this.score,
    this.type,
    this.radialDistanceInKm,
  );

  /// Creates a BaatoSearchPlace from JSON data
  ///
  /// [json] - The JSON object containing place data
  factory BaatoSearchPlace.fromJson(dynamic json) {
    double radialDistanceInKm =
        double.tryParse(json['radialDistanceInKm'].toString()) ?? 0.0;
    return BaatoSearchPlace(
      json['placeId'] as int,
      json['osmId'] as int,
      json['name'] as String,
      json['address'] as String,
      json['score'] as double,
      json['type'] as String,
      radialDistanceInKm,
    );
  }

  @override
  String toString() {
    return 'BaatoSearchPlace{placeId: $placeId, baatoId: $baatoId, name: $name, address: $address, score: $score, type: $type, radialDistanceInKm: $radialDistanceInKm}';
  }
}

/// Represents a response from the Baato search API
///
/// Contains metadata about the response and a list of search results
class BaatoSearchPlaceResponse {
  /// The timestamp when the response was generated
  final String timestamp;

  /// The HTTP status code of the response
  final int status;

  /// A message describing the response status
  final String message;

  /// The list of search result places
  final List<BaatoSearchPlace>? data;

  /// Creates a new BaatoSearchPlaceResponse instance
  ///
  /// [timestamp] - The timestamp when the response was generated
  /// [status] - The HTTP status code of the response
  /// [message] - A message describing the response status
  /// [data] - Optional list of search result places
  BaatoSearchPlaceResponse(
    this.timestamp,
    this.status,
    this.message, [
    this.data,
  ]);

  /// Creates a BaatoSearchPlaceResponse from JSON data
  ///
  /// [json] - The JSON object containing the response data
  factory BaatoSearchPlaceResponse.fromJson(dynamic json) {
    var responseDataJson = json['data'] as List;
    List<BaatoSearchPlace> _searchResults =
        responseDataJson
            .map((searchJson) => BaatoSearchPlace.fromJson(searchJson))
            .toList();

    return BaatoSearchPlaceResponse(
      json['timestamp'] as String,
      json['status'] as int,
      json['message'] as String,
      _searchResults,
    );
  }

  @override
  String toString() {
    return 'BaatoSearchPlaceResponse{timestamp: $timestamp, status: $status, message: $message, data: $data}';
  }
}
