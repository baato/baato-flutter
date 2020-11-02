[![Pub](https://img.shields.io/pub/v/baato_api.svg)](https://pub.dev/packages/baato_api)

# baato-api

Flutter library to help you consume [Baato](https://baato.io) APIs.

## Features

* Search
* Reverse Geocoding
* Places
* Directions

### Implementation

 #### 1. Search 
 After initializing Baato with your access token and the query, the `searchQuery` method can be used to make requests to the Search API.
 
```
import 'package:baato_api/baato_api.dart';
import 'package:baato_api/models/search.dart';

void main() async {
  String baatoAccessToken = "your-baato-access-token";

  BaatoSearch baatoSearch = BaatoSearch.initialize(
    query: 'your-query',
    accessToken: baatoAccessToken,
    type: 'school', //optional parameter
    limit: 5, //optional parameter
  );

  //perform Search
  SearchResponse response = await baatoSearch.searchQuery();
  print(response);
}

```
 #### 2. Reverse GeoCode

 ```
import 'package:baato_api/baato_api.dart';
import 'package:baato_api/models/place.dart';

void main() async {
  String baatoAccessToken = "your-baato-access-token";

  BaatoReverse baatoReverse = BaatoReverse.initialize(
    latLon: GeoCoord(lat, lon),
    accessToken: baatoAccessToken,
  );

  //perform reverse Search
  PlaceResponse reverse = await baatoReverse.reverseGeocode();
  print(reverse);
}

```
#### 3. Places

 ```
import 'package:baato_api/baato_api.dart';
import 'package:baato_api/models/place.dart';

void main() async {
  String baatoAccessToken = "your-baato-access-token";

  BaatoPlace baatoPlace = BaatoPlace.initialize(
    placeId: placeId, //placeId is required parameter
    accessToken: baatoAccessToken, //accessToken is required parameter
  );

  //perform the place lookup
  PlaceResponse placeResponse = await baatoPlace.getPlaceDetails();
  print(placeResponse);
}

```
#### 4. Directions

 ```
import 'package:baato_api/baato_api.dart';
import 'package:baato_api/models/route.dart';

void main() async {
  var points = [];
  points.add("27.717844,85.3248188");
  points.add("27.6876224,85.33827");

  String baatoAccessToken = "your-baato-access-token";

  BaatoRoute baatoRoute = BaatoRoute.initialize(
      accessToken: baatoAccessToken,
      points: points,
      mode: "car", //can be 'bike', 'car', 'foot'
      alternatives: false, //optional parameter
      instructions: false); //optional parameter

  //get routes between start and destination point
  RouteResponse response = await baatoRoute.getRoutes();
  print(response);
}

```
