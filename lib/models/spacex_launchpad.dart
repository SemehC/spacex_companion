class SpaceXLaunchPad {
  final String name;
  final String fullName;
  final String locality;
  final String region;
  final String timezone;
  final double latitude;
  final double longitude;
  final int launchAttempts;
  final int launchSuccesses;
  final List<dynamic> rockets;
  final List<dynamic> launches;
  final String status;
  final String id;

  SpaceXLaunchPad({
    required this.name,
    required this.fullName,
    required this.locality,
    required this.region,
    required this.timezone,
    required this.latitude,
    required this.longitude,
    required this.launchAttempts,
    required this.launchSuccesses,
    required this.rockets,
    required this.launches,
    required this.status,
    required this.id,
  });

  static fromDocument(dynamic json) {
    return SpaceXLaunchPad(
      name: json['name'],
      fullName: json['full_name'],
      locality: json['locality'],
      region: json['region'],
      timezone: json['timezone'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      launchAttempts: json['launch_attempts'],
      launchSuccesses: json['launch_successes'],
      rockets: json['rockets'],
      launches: json['launches'],
      status: json['status'],
      id: json['id'],
    );
  }
}
