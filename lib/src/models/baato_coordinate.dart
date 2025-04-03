/// Represents a geographic coordinate from the Baato API
///
/// Contains latitude and longitude values that define a point on the Earth's surface
class BaatoCoordinate {
  /// The latitude value in decimal degrees
  final double latitude;

  /// The longitude value in decimal degrees
  final double longitude;

  /// Creates a new BaatoCoordinate instance
  ///
  /// [latitude] - The latitude in decimal degrees
  /// [longitude] - The longitude in decimal degrees
  BaatoCoordinate(this.latitude, this.longitude);

  /// Creates a BaatoCoordinate from JSON data
  ///
  /// [json] - The JSON object containing coordinate data
  factory BaatoCoordinate.fromJson(Map<String, dynamic> json) {
    final latitude = double.parse(json['lat'].toString());
    final longitude = double.parse(json['lon'].toString());
    return BaatoCoordinate(latitude, longitude);
  }

  /// Converts this coordinate to a JSON representation
  ///
  /// Returns a map containing the latitude and longitude values
  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }

  @override
  String toString() {
    return 'BaatoCoordinate{latitude: $latitude, longitude: $longitude}';
  }
}
