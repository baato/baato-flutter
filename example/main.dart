import 'package:baato_api/models/place.dart';
import 'package:baato_api/models/route.dart';
import 'package:baato_api/models/search.dart';
import 'package:baato_api/src/baato_place.dart';
import 'package:baato_api/src/baato_reverse.dart';
import 'package:baato_api/src/baato_route.dart';
import 'package:baato_api/src/baato_search.dart';
import 'package:baato_api/src/baato_utils.dart';

void main() async {
  String baatoAccessToken = "your-baato-access-token";

  var points = [];
  points.add("27.717844,85.3248188");
  points.add("27.6876224,85.33827");

  BaatoSearch baatoSearch = BaatoSearch.initialize(
    query: 'naxal',
    type: 'school', //optional parameter
    limit: 5, //optional parameter
    accessToken: baatoAccessToken,
  );

  BaatoReverse baatoReverse = BaatoReverse.initialize(
    latLon: GeoCoord(27.7146921370009, 85.32051086425783),
    accessToken: baatoAccessToken,
  );

  BaatoPlace baatoPlace = BaatoPlace.initialize(
    placeId: 101373,
    accessToken: baatoAccessToken,
  );

  BaatoRoute baatoRoute = BaatoRoute.initialize(
      mode: "car",
      //can be 'bike', 'car', 'foot'
      accessToken: baatoAccessToken,
      points: points,
      alternatives: false,
      //optional parameter
      instructions: false); //optional parameter

  SearchResponse searchResponse = await baatoSearch.searchQuery();
  print(searchResponse);

  PlaceResponse reverseResponse = await baatoReverse.reverseGeocode();
  print(reverseResponse);

  PlaceResponse placeResponse = await baatoPlace.getPlaceDetails();
  print(placeResponse);

  RouteResponse routeResponse = await baatoRoute.getRoutes();
  print("route response $routeResponse");

  //if you need to decode the encoded polyline from the response
  List<GeoCoord> routePoints;
  routePoints = BaatoUtils()
      .decodeEncodedPolyline(routeResponse.data![0].encodedPolyline!);
  print("decoded route $routePoints");
}
