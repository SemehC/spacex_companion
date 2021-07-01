class SpaceXPayload {
  final Map<String, dynamic> dragon;
  final String name;
  final String type;
  final bool reused;
  final String launch;
  final List<dynamic> customers;
  final List<dynamic> noradIds;
  final List<dynamic> nationalities;
  final List<dynamic> manufacturers;
  final double massKg;
  final double massLbs;
  final String orbit;
  final String referenceSystem;
  final String regime;
  final double longitude;
  final double semiMajorAxisKm;
  final double eccentricity;
  final double periapsisKm;
  final double apoapsisKm;
  final double inclinationDeg;
  final double periodMin;
  final int lifespanYears;
  final String epoch;
  final double meanMotion;
  final double raan;
  final double argOfPericenter;
  final double meanAnomaly;
  final String id;

  SpaceXPayload({
    required this.dragon,
    required this.name,
    required this.type,
    required this.reused,
    required this.launch,
    required this.customers,
    required this.noradIds,
    required this.nationalities,
    required this.manufacturers,
    required this.massKg,
    required this.massLbs,
    required this.orbit,
    required this.referenceSystem,
    required this.regime,
    required this.longitude,
    required this.semiMajorAxisKm,
    required this.eccentricity,
    required this.periapsisKm,
    required this.apoapsisKm,
    required this.inclinationDeg,
    required this.periodMin,
    required this.lifespanYears,
    required this.epoch,
    required this.meanMotion,
    required this.raan,
    required this.argOfPericenter,
    required this.meanAnomaly,
    required this.id,
  });

  static fromDocument(dynamic json) {
    return SpaceXPayload(
      dragon: json['dragon'] ?? [],
      name: json['name'] ?? "",
      type: json['type'] ?? "",
      reused: json['reused'] ?? false,
      launch: json['launch'] ?? "",
      customers: json['customers'] ?? [],
      noradIds: json['norad_ids'] ?? [],
      nationalities: json['nationalities'] ?? [],
      manufacturers: json['manufacturers'] ?? [],
      massKg: json['mass_kg'] != null ? json['mass_kg'].toDouble() : 0,
      massLbs: json['mass_lbs'] != null ? json['mass_lbs'].toDouble() : 0,
      orbit: json['orbit'] ?? "",
      referenceSystem: json['reference_system'] ?? "",
      regime: json['regime'] ?? "",
      longitude: json['longitude'] != null ? json['longitude'].toDouble() : 0,
      semiMajorAxisKm: json['semi_major_axis_km'] ?? 0,
      eccentricity: json['eccentricity'] ?? 0,
      periapsisKm: json['periapsis_km'] != json['periapsis_km']
          ? json['periapsis_km'].toDouble()
          : 0,
      apoapsisKm: json['apoapsis_km'] ?? 0,
      inclinationDeg: json['inclination_deg'] ?? 0,
      periodMin: json['period_min'] ?? 0,
      lifespanYears: json['lifespan_years'] ?? 0,
      epoch: json['epoch'] ?? "",
      meanMotion: json['meanMotion'] ?? 0,
      raan: json['raan'] ?? 0,
      argOfPericenter: json['arg_of_pericenter'] ?? 0,
      meanAnomaly: json['meanAnomaly'] ?? 0,
      id: json['id'] ?? "",
    );
  }
}
