/// @deprecated This class is deprecated and will be removed in a future version.
/// Please use the newer models in the main package instead.
@deprecated
class Search {
  final int placeId;
  final String name;
  final String address;
  final double score;
  final String type;

  /// @deprecated This constructor is deprecated and will be removed in a future version.
  @deprecated
  Search(this.placeId, this.name, this.address, this.score, this.type);

  /// @deprecated This factory is deprecated and will be removed in a future version.
  @deprecated
  factory Search.fromJson(dynamic json) {
    return Search(
      json['placeId'] as int,
      json['name'] as String,
      json['address'] as String,
      json['score'] as double,
      json['type'] as String,
    );
  }

  @override
  String toString() {
    return 'Search{placeId: $placeId, name: $name, address: $address, score: $score, type: $type}';
  }
}

/// @deprecated This class is deprecated and will be removed in a future version.
/// Please use the newer models in the main package instead.
@deprecated
class SearchResponse {
  final String timestamp;
  final int status;
  final String message;
  final List<Search>? data;

  /// @deprecated This constructor is deprecated and will be removed in a future version.
  @deprecated
  SearchResponse(this.timestamp, this.status, this.message, [this.data]);

  /// @deprecated This factory is deprecated and will be removed in a future version.
  @deprecated
  factory SearchResponse.fromJson(dynamic json) {
    var responseDataJson = json['data'] as List;
    List<Search> _searchResults =
        responseDataJson
            .map((searchJson) => Search.fromJson(searchJson))
            .toList();

    return SearchResponse(
      json['timestamp'] as String,
      json['status'] as int,
      json['message'] as String,
      _searchResults,
    );
  }

  @override
  String toString() {
    return 'SearchResponse{timestamp: $timestamp, status: $status, message: $message, data: $data}';
  }
}
