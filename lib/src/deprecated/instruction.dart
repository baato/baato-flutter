/// @deprecated This class is deprecated and will be removed in a future version.
/// Please use the newer models in the main package instead.
@deprecated
class Instruction {
  Points? points;
  Annotation? annotation;
  int? sign;
  String? name;
  double? distance;
  int? time;
  ExtraInfoJSON? extraInfoJSON;
  int? length;

  /// @deprecated This constructor is deprecated and will be removed in a future version.
  @deprecated
  Instruction({
    this.points,
    this.annotation,
    this.sign,
    this.name,
    this.distance,
    this.time,
    this.extraInfoJSON,
    this.length,
  });

  /// @deprecated This factory is deprecated and will be removed in a future version.
  @deprecated
  Instruction.fromJson(Map<String, dynamic> json) {
    points =
        json['points'] != null ? new Points.fromJson(json['points']) : null;
    annotation =
        json['annotation'] != null
            ? new Annotation.fromJson(json['annotation'])
            : null;
    sign = json['sign'];
    name = json['name'];
    distance = json['distance'];
    time = json['time'];
    extraInfoJSON =
        json['extraInfoJSON'] != null
            ? new ExtraInfoJSON.fromJson(json['extraInfoJSON'])
            : null;
    length = json['length'];
  }

  /// @deprecated This method is deprecated and will be removed in a future version.
  @deprecated
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final points = this.points;
    final annotation = this.annotation;
    final extraInfoJSON = this.extraInfoJSON;

    if (points != null) {
      data['points'] = points.toJson();
    }
    if (annotation != null) {
      data['annotation'] = annotation.toJson();
    }
    data['sign'] = this.sign;
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['time'] = this.time;
    if (extraInfoJSON != null) {
      data['extraInfoJSON'] = extraInfoJSON.toJson();
    }
    data['length'] = this.length;
    return data;
  }

  @override
  String toString() {
    return 'Instruction{points: $points, annotation: $annotation, sign: $sign, name: $name, distance: $distance, time: $time, extraInfoJSON: $extraInfoJSON, length: $length}';
  }
}

/// @deprecated This class is deprecated and will be removed in a future version.
/// Please use the newer models in the main package instead.
@deprecated
class Points {
  int? size;
  String? intervalString;
  bool? immutable;
  bool? b3D;
  int? dimension;
  bool? empty;

  /// @deprecated This constructor is deprecated and will be removed in a future version.
  @deprecated
  Points({
    this.size,
    this.intervalString,
    this.immutable,
    this.b3D,
    this.dimension,
    this.empty,
  });

  /// @deprecated This factory is deprecated and will be removed in a future version.
  @deprecated
  Points.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    intervalString = json['intervalString'];
    immutable = json['immutable'];
    b3D = json['3D'];
    dimension = json['dimension'];
    empty = json['empty'];
  }

  /// @deprecated This method is deprecated and will be removed in a future version.
  @deprecated
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['intervalString'] = this.intervalString;
    data['immutable'] = this.immutable;
    data['3D'] = this.b3D;
    data['dimension'] = this.dimension;
    data['empty'] = this.empty;
    return data;
  }

  @override
  String toString() {
    return 'Points{size: $size, intervalString: $intervalString, immutable: $immutable, b3D: $b3D, dimension: $dimension, empty: $empty}';
  }
}

/// @deprecated This class is deprecated and will be removed in a future version.
/// Please use the newer models in the main package instead.
@deprecated
class Annotation {
  bool? empty;
  int? importance;
  String? message;

  /// @deprecated This constructor is deprecated and will be removed in a future version.
  @deprecated
  Annotation({this.empty, this.importance, this.message});

  /// @deprecated This factory is deprecated and will be removed in a future version.
  @deprecated
  Annotation.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    importance = json['importance'];
    message = json['message'];
  }

  /// @deprecated This method is deprecated and will be removed in a future version.
  @deprecated
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empty'] = this.empty;
    data['importance'] = this.importance;
    data['message'] = this.message;
    return data;
  }

  @override
  String toString() {
    return 'Annotation{empty: $empty, importance: $importance, message: $message}';
  }
}

/// @deprecated This class is deprecated and will be removed in a future version.
/// Please use the newer models in the main package instead.
@deprecated
class ExtraInfoJSON {
  double? heading;

  /// @deprecated This constructor is deprecated and will be removed in a future version.
  @deprecated
  ExtraInfoJSON({this.heading});

  /// @deprecated This factory is deprecated and will be removed in a future version.
  @deprecated
  ExtraInfoJSON.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
  }

  /// @deprecated This method is deprecated and will be removed in a future version.
  @deprecated
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heading'] = this.heading;
    return data;
  }

  @override
  String toString() {
    return 'ExtraInfoJSON{heading: $heading}';
  }
}
