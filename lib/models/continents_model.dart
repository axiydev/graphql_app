class ContinentsModel {
  final List<Continent?>? continents;
  ContinentsModel({required this.continents});

  factory ContinentsModel.fromJson(dynamic json) {
    return ContinentsModel(
        continents: json['continents'] == null
            ? null
            : List<Continent?>.from(
                json['continents'].map((e) => Continent.fromJson(e))));
  }
}

class Continent {
  final String? name;
  final dynamic? code;
  Continent({required this.name, required this.code});
  factory Continent.fromJson(dynamic json) {
    return Continent(name: json['name'], code: json['code']);
  }

  Map<String, dynamic> toJson() => {'code': code, 'name': name};
}
