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
    query: 'your-query',  //required parameter
    accessToken: baatoAccessToken, //required parameter
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
