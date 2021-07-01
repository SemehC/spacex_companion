class SpaceXLaunch implements Comparable {
  final Map<String, dynamic> fairings;
  final Map<String, dynamic> links;
  final String fireDateUTC;
  final int fireDateUNIX;
  final bool tbd;
  final bool net;
  final int window;
  final String rocket;
  final int success;
  final List<dynamic> failures;
  final String details;
  final List<dynamic> crew;
  final List<dynamic> ships;
  final List<dynamic> capsules;
  final List<dynamic> payloads;
  final String launchpad;
  final bool autoUpdate;
  final int flightNumber;
  final String name;
  final DateTime dateUTC;
  final int dateUNIX;
  final String dateLocal;
  final String datePrecision;
  final bool upcoming;
  final List<dynamic> cores;
  final String id;

  SpaceXLaunch({
    required this.fairings,
    required this.links,
    required this.fireDateUTC,
    required this.fireDateUNIX,
    required this.tbd,
    required this.net,
    required this.window,
    required this.rocket,
    required this.success,
    required this.failures,
    required this.details,
    required this.crew,
    required this.ships,
    required this.capsules,
    required this.payloads,
    required this.launchpad,
    required this.autoUpdate,
    required this.flightNumber,
    required this.name,
    required this.dateUTC,
    required this.dateUNIX,
    required this.dateLocal,
    required this.datePrecision,
    required this.upcoming,
    required this.cores,
    required this.id,
  });

  static fromDocument(dynamic json) {
    return SpaceXLaunch(
      fairings:
          json['fairings'] == null ? Map<String, dynamic>() : json['fairings'],
      links: json['links'],
      fireDateUTC: json['static_fire_date_utc'] == null
          ? ""
          : json['static_fire_date_utc'],
      fireDateUNIX: json['static_fire_date_unix'] == null
          ? -1
          : json['static_fire_date_unix'],
      tbd: json['tbd'],
      net: json['net'],
      window: json['window'] == null ? -1 : json['window'],
      rocket: json['rocket'],
      success: json['success'] == null
          ? -1
          : json['success'] == true
              ? 1
              : 0,
      failures: json['failures'],
      details: json['details'] == null ? "" : json['details'],
      crew: json['crew'],
      ships: json['ships'],
      capsules: json['capsules'],
      payloads: json['payloads'],
      launchpad: json['launchpad'],
      autoUpdate: json['auto_update'],
      flightNumber: json['flight_number'],
      name: json['name'],
      dateUTC: DateTime.parse(json['date_utc']),
      dateUNIX: json['date_unix'],
      dateLocal: json['date_local'],
      datePrecision: json['date_precision'],
      upcoming: json['upcoming'],
      cores: json['cores'],
      id: json['id'],
    );
  }

  @override
  int compareTo(other) {
    if (this.dateUTC.isBefore(other.dateUTC)) {
      return 1;
    }

    if (this.dateUTC.isAfter(other.dateUTC)) {
      return -1;
    }

    if (this.dateUTC.isAtSameMomentAs(other.dateUTC)) {
      return 0;
    }

    return 0;
  }
}
