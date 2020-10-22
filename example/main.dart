import 'package:baato_api/models/place.dart';
import 'package:baato_api/models/search.dart';
import 'package:baato_api/src/baato_place.dart';
import 'package:baato_api/src/baato_reverse.dart';
import 'package:baato_api/src/baato_search.dart';

void main() async {
  String baatoAccessToken = "your-baato-access-token";
  BaatoSearch baatoSearch = BaatoSearch.initialize(
    query: 'naxal',
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

  SearchResponse response = await baatoSearch.searchQuery();
  print(response);

  PlaceResponse reverse = await baatoReverse.reverseGeocode();
  print(reverse);

  PlaceResponse placeResponse = await baatoPlace.getPlaceDetails();
  print(placeResponse);
}
