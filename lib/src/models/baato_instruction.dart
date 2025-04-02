/// Represents a navigation instruction from the Baato API
///
/// Contains details about a navigation step including distance, time, and other attributes
class BaatoInstruction {
  /// Points information for the instruction
  Points? points;

  /// Annotation information for the instruction
  Annotation? annotation;

  /// Sign code indicating the type of instruction (e.g., turn right, continue straight)
  int? sign;

  /// Name of the road or path for this instruction
  String? name;

  /// Distance to travel for this instruction in meters
  double? distance;

  /// Time to travel for this instruction in milliseconds
  int? time;

  /// Extra information about the instruction
  ExtraInfoJSON? extraInfoJSON;

  /// Length of the instruction in number of points
  int? length;

  /// Creates a new BaatoInstruction instance
  ///
  /// [points] - Points information for the instruction
  /// [annotation] - Annotation information for the instruction
  /// [sign] - Sign code indicating the type of instruction
  /// [name] - Name of the road or path
  /// [distance] - Distance to travel in meters
  /// [time] - Time to travel in milliseconds
  /// [extraInfoJSON] - Extra information about the instruction
  /// [length] - Length of the instruction in number of points
  BaatoInstruction({
    this.points,
    this.annotation,
    this.sign,
    this.name,
    this.distance,
    this.time,
    this.extraInfoJSON,
    this.length,
  });

  /// Creates a BaatoInstruction from JSON data
  ///
  /// [json] - The JSON object containing instruction data
  BaatoInstruction.fromJson(Map<String, dynamic> json) {
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

  /// Converts this BaatoInstruction to a JSON object
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
    return 'BaatoInstruction{points: $points, annotation: $annotation, sign: $sign, name: $name, distance: $distance, time: $time, extraInfoJSON: $extraInfoJSON, length: $length}';
  }
}

/// Represents points information for a navigation instruction
class Points {
  /// Number of points in the instruction
  int? size;

  /// String representation of the interval
  String? intervalString;

  /// Whether the points are immutable
  bool? immutable;

  /// Whether the points have 3D coordinates
  bool? b3D;

  /// Dimension of the points (2 for 2D, 3 for 3D)
  int? dimension;

  /// Whether the points collection is empty
  bool? empty;

  /// Creates a new Points instance
  Points({
    this.size,
    this.intervalString,
    this.immutable,
    this.b3D,
    this.dimension,
    this.empty,
  });

  /// Creates a Points object from JSON data
  Points.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    intervalString = json['intervalString'];
    immutable = json['immutable'];
    b3D = json['3D'];
    dimension = json['dimension'];
    empty = json['empty'];
  }

  /// Converts this Points object to a JSON object
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

/// Represents annotation information for a navigation instruction
class Annotation {
  /// Whether the annotation is empty
  bool? empty;

  /// Importance level of the annotation
  int? importance;

  /// Message content of the annotation
  String? message;

  /// Creates a new Annotation instance
  Annotation({this.empty, this.importance, this.message});

  /// Creates an Annotation object from JSON data
  Annotation.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    importance = json['importance'];
    message = json['message'];
  }

  /// Converts this Annotation object to a JSON object
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

/// Represents extra information for a navigation instruction
class ExtraInfoJSON {
  /// Heading direction in degrees (0-360)
  double? heading;

  /// Creates a new ExtraInfoJSON instance
  ExtraInfoJSON({this.heading});

  /// Creates an ExtraInfoJSON object from JSON data
  ExtraInfoJSON.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
  }

  /// Converts this ExtraInfoJSON object to a JSON object
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
