class SpaceXCapsule {
  final int reuseCount;
  final int waterLandings;
  final int landLandings;
  final String lastUpdate;
  final List<dynamic> launches;
  final String serial;
  final String status;
  final String type;
  final String id;

  SpaceXCapsule({
    required this.reuseCount,
    required this.waterLandings,
    required this.landLandings,
    required this.lastUpdate,
    required this.launches,
    required this.serial,
    required this.status,
    required this.type,
    required this.id,
  });

  static fromDocument(dynamic json) {
    return SpaceXCapsule(
      reuseCount: json['reuseCount'] ?? 0,
      waterLandings: json['waterLandings'] ?? 0,
      landLandings: json['landLandings'] ?? 0,
      lastUpdate: json['lastUpdate'] ?? "",
      launches: json['launches'] ?? [],
      serial: json['serial'] ?? "",
      status: json['status'] ?? "",
      type: json['type'] ?? "",
      id: json['id'] ?? "",
    );
  }
}
