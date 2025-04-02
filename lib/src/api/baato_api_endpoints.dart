/// Enum representing the available Baato API endpoints
enum BaatoApiEndpoint {
  /// Search endpoint for finding places
  search('/search'),

  /// Nearby endpoint for finding places nearby a specific location
  nearby('/search/nearby'),

  /// Reverse geocode endpoint for getting place information from coordinates
  reverseGeocode('/reverse'),

  /// Places endpoint for getting details about a specific place
  places('/places'),

  /// Directions endpoint for routing
  directions('/directions');

  /// The path of the endpoint
  final String path;

  /// Constructor for BaatoApiEndpoint
  const BaatoApiEndpoint(this.path);

  @override
  String toString() => path;
}
