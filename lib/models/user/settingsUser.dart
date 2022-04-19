class UserSettings {
  final String name;
  final String email;
  final String fuelType;
  final String fuelSize;
  UserSettings(
      {required this.name,
      required this.email,
      required this.fuelType,
      required this.fuelSize});

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
        name: json['Name'],
        email: json['Email'],
        fuelType: json['FuelType'],
        fuelSize: json['FuelSize']);
  }
}
