class Country {
  final String name;
  final String capital;

  Country(
    this.name,
    this.capital,
  );

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      json["name"],
      json["capital"],
    );
  }
}
