class LocationModel {
  double latitude;
  double longitude;
  String address;
  String locationName;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.locationName,
  });

  // Factory constructor to create a LocationModel from a JSON map
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      address: json['address'] as String,
      locationName: json['locationName'] as String,
    );
  }

  // Method to convert LocationModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'locationName': locationName,
    };
  }

  static List<LocationModel> getAllLocations() {
    return [
      LocationModel(
        latitude: 44.6488,
        longitude: -63.5752,
        address: "123 Waterfront Dr, Halifax",
        locationName: "Anjali Home",
      ),
      LocationModel(
        latitude: 44.6714,
        longitude: -63.5772,
        address: "456 Spring Garden Rd, Halifax",
        locationName: "Dalhousie library",
      ),
      LocationModel(
        latitude: 44.6351,
        longitude: -63.5753,
        address: "789 Citadel Hill, Halifax",
        locationName: "Nikul Office",
      ),
    ];
  }
}
