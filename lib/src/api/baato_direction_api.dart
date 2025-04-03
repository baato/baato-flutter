import 'package:baato_api/src/api/baato_api_endpoints.dart';
import 'package:baato_api/src/api/baato_dio.dart';
import 'package:baato_api/src/models/export_model.dart';

abstract class BaatoDirectionAPI {
  Future<BaatoRouteResponse> getRoutes({
    required BaatoCoordinate startCoordinate,
    required BaatoCoordinate endCoordinate,
    required BaatoDirectionMode mode,
    List<BaatoCoordinate> midCoordinates,
    bool alternatives,
    bool instructions,
  });

  Future<Map<String, dynamic>?> getRouteForMapbox({
    required BaatoCoordinate startCoordinate,
    required BaatoCoordinate endCoordinate,
    required BaatoDirectionMode mode,
    bool alternatives,
    bool instructions,
  });
}

class BaatoDirectionImpl implements BaatoDirectionAPI {
  final BaatoDio dio;

  BaatoDirectionImpl({required this.dio});

  @override
  Future<BaatoRouteResponse> getRoutes({
    required BaatoCoordinate startCoordinate,
    required BaatoCoordinate endCoordinate,
    required BaatoDirectionMode mode,
    List<BaatoCoordinate> midCoordinates = const [],
    bool alternatives = false,
    bool instructions = false,
  }) async {
    final List<String> points = [
      "${startCoordinate.latitude},${startCoordinate.longitude}",
    ];

    if (midCoordinates.isNotEmpty) {
      points.addAll(midCoordinates.map((e) => "${e.latitude},${e.longitude}"));
    }

    points.add("${endCoordinate.latitude},${endCoordinate.longitude}");

    final queryParams = {
      'points[]': points,
      'mode': mode.name,
      'alternatives': alternatives,
      'instructions': instructions,
      'forMapbox': false,
    };

    final response = await dio.get(
      BaatoApiEndpoint.directions,
      queryParameters: queryParams,
    );
    return BaatoRouteResponse.fromJson(response.data);
  }

  @override
  Future<Map<String, dynamic>?> getRouteForMapbox({
    required BaatoCoordinate startCoordinate,
    required BaatoCoordinate endCoordinate,
    required BaatoDirectionMode mode,
    bool alternatives = false,
    bool instructions = false,
  }) async {
    final List<String> points = [
      "${startCoordinate.latitude},${startCoordinate.longitude}",
      "${endCoordinate.latitude},${endCoordinate.longitude}",
    ];

    final queryParams = {
      'points[]': points,
      'mode': mode.name,
      'alternatives': alternatives,
      'instructions': instructions,
      'forMapbox': true,
    };

    final response = await dio.get(
      BaatoApiEndpoint.directions,
      queryParameters: queryParams,
    );

    print(response.data);
    print(">>>>");

    return response.data;
  }
}
