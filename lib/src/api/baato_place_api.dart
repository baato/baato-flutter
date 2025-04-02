import 'package:baato_api/src/models/baato_place.dart';
import 'package:baato_api/src/models/baato_search_place.dart';
import 'package:baato_api/src/models/baato_coordinate.dart';
import 'package:baato_api/src/api/baato_api_endpoints.dart';
import 'package:baato_api/src/api/baato_dio.dart';

/// Interface for interacting with Baato Place API endpoints
///
/// Defines methods for searching places, getting place details,
/// and performing reverse geocoding operations
abstract class BaatoPlaceAPI {
  /// Searches for places based on a query string
  ///
  /// [query] - The search query text
  /// [limit] - Maximum number of results to return
  /// [type] - Optional filter for place types
  /// [radius] - Optional search radius in meters
  /// [currentCoordinate] - Optional current location coordinates
  Future<BaatoSearchPlaceResponse> searchPlaces(
    String query, {
    int limit,
    String? type,
    int? radius,
    BaatoCoordinate? currentCoordinate,
  });

  /// Retrieves places near a specific location
  ///
  /// [coordinates] - The geographic coordinates to search around
  /// [type] - The type of places to search for
  /// [sortByDistance] - Whether to sort results by distance
  /// [limit] - Optional maximum number of results to return
  /// [radius] - Optional search radius in meters
  Future<BaatoPlaceResponse> nearByPlaces(
    BaatoCoordinate coordinates, {
    required String type,
    bool sortByDistance,
    int? limit,
    int? radius,
    bool? isOpen,
  });

  /// Retrieves detailed information about a specific place
  ///
  /// [placeId] - The unique identifier of the place
  Future<BaatoPlaceResponse> getPlaceDetails(int placeId);

  /// Performs reverse geocoding to find places near specified coordinates
  ///
  /// [coordinates] - The geographic coordinates to search around
  /// [radius] - Optional search radius in meters
  /// [limit] - Optional maximum number of results to return
  Future<BaatoPlaceResponse> reverseGeocode(
    BaatoCoordinate coordinates, {
    bool adminInfo,
    int? radius,
    int? limit,
  });
}

/// Implementation of the BaatoPlace for interacting with Baato Place API
///
/// Provides methods to search places, get place details, and perform reverse geocoding
class BaatoPlaceImpl implements BaatoPlaceAPI {
  /// The Dio client configured for Baato API requests
  final BaatoDio dio;

  /// Creates a new BaatoPlaces instance
  ///
  /// [dio] - The configured BaatoDio instance for making API requests
  BaatoPlaceImpl({required this.dio});

  @override
  Future<BaatoPlaceResponse> getPlaceDetails(int placeId) async {
    final response = await dio.get(
      BaatoApiEndpoint.places,
      queryParameters: {'placeId': placeId},
    );
    return BaatoPlaceResponse.fromJson(response.data);
  }

  @override
  Future<BaatoPlaceResponse> reverseGeocode(
    BaatoCoordinate coordinates, {
    int? radius,
    int? limit,
    bool adminInfo = false,
  }) async {
    final queryParams = <String, dynamic>{
      'lat': coordinates.latitude,
      'lon': coordinates.longitude,
      'adminInfo': adminInfo,
    };

    if (radius != null) queryParams['radius'] = radius;
    if (limit != null) queryParams['limit'] = limit;

    final response = await dio.get(
      BaatoApiEndpoint.reverseGeocode,
      queryParameters: queryParams,
    );
    return BaatoPlaceResponse.fromJson(response.data);
  }

  @override
  Future<BaatoSearchPlaceResponse> searchPlaces(
    String query, {
    int limit = 5,
    String? type,
    int? radius,
    BaatoCoordinate? currentCoordinate,
  }) async {
    final queryParams = {'q': query, 'limit': limit};

    if (type != null) queryParams['type'] = type;
    if (radius != null) queryParams['radius'] = radius;
    if (currentCoordinate != null) {
      queryParams['lat'] = currentCoordinate.latitude;
      queryParams['lon'] = currentCoordinate.longitude;
    }

    final response = await dio.get(
      BaatoApiEndpoint.search,
      queryParameters: queryParams,
    );
    return BaatoSearchPlaceResponse.fromJson(response.data);
  }

  @override
  Future<BaatoPlaceResponse> nearByPlaces(
    BaatoCoordinate coordinates, {
    required String type,
    bool sortByDistance = true,
    int? limit,
    int? radius,
    bool? isOpen,
  }) async {
    final queryParams = {'type': type, 'sortBy': sortByDistance};

    if (radius != null) queryParams['radius'] = radius;
    if (limit != null) queryParams['limit'] = limit;
    if (isOpen != null) queryParams['isOpen'] = isOpen;
    queryParams['lat'] = coordinates.latitude;
    queryParams['lon'] = coordinates.longitude;

    final response = await dio.get(
      BaatoApiEndpoint.nearby,
      queryParameters: queryParams,
    );
    return BaatoPlaceResponse.fromJson(response.data);
  }
}
