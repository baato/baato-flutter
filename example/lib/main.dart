import 'package:baato_api/models/place.dart';
import 'package:baato_api/models/route.dart';

import 'package:baato_api/baato_api.dart';
import 'package:baato_api/models/search.dart';

// Visit https://baato.io/ to get your ACCESS token

void main() async {
  String baatoAccessToken = "YOUR_ACCESS_TOKEN";

//Baato Search

  BaatoSearch baatoSearch = BaatoSearch.initialize(
    query: 'Teaching Hospital',
    accessToken: baatoAccessToken,
    type: 'hospital', //optional parameter
    limit: 5, //optional parameter
  );

  //perform Search
  SearchResponse response = await baatoSearch.searchQuery();
  print(response);

  //Baato Route

  var points = [];
  points.add("27.717844,85.3248188");
  points.add("27.6876224,85.33827");

  BaatoRoute baatoRoute = BaatoRoute.initialize(
      accessToken: baatoAccessToken,
      points: points,
      mode: "car", //can be 'bike', 'car', 'foot'
      alternatives: false, //optional parameter
      instructions: false); //optional parameter

  //get routes between start and destination point
  RouteResponse responseRoute = await baatoRoute.getRoutes();
  print(responseRoute);

  //Baato Route END

  //Place 

  BaatoPlace baatoPlace = BaatoPlace.initialize(
    placeId: 156068, //placeId is required parameter
    accessToken: baatoAccessToken, //accessToken is required parameter
  );

  //perform the place lookup
  PlaceResponse placeResponse = await baatoPlace.getPlaceDetails();
  print(placeResponse);

 //Place END

//Reverse Baato

  BaatoReverse baatoReverse = BaatoReverse.initialize(
    latLon: GeoCoord(27.7340912, 85.3368392),
    accessToken: baatoAccessToken,
  );

  //perform reverse Search
  PlaceResponse reverse = await baatoReverse.reverseGeocode();
  print(reverse);
}
