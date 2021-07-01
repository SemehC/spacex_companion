class SpaceXRocket {
  final Map<String, dynamic> height;
  final Map<String, dynamic> diameter;
  final Map<String, dynamic> mass;
  final Map<String, dynamic> firstStage;
  final Map<String, dynamic> secondStage;
  final Map<String, dynamic> engines;
  final Map<String, dynamic> landingLegs;
  final List<dynamic> payloadWeights;
  final List<dynamic> flickrImages;
  final String name;
  final String type;
  final bool active;
  final int stages;
  final int boosters;
  final int costPerLaunchaunch;
  final int successRatePct;
  final String firstFlight;
  final String country;
  final String company;
  final String wikipedia;
  final String description;
  final String id;

  SpaceXRocket({
    required this.height,
    required this.diameter,
    required this.mass,
    required this.firstStage,
    required this.secondStage,
    required this.engines,
    required this.landingLegs,
    required this.payloadWeights,
    required this.flickrImages,
    required this.name,
    required this.type,
    required this.active,
    required this.stages,
    required this.boosters,
    required this.costPerLaunchaunch,
    required this.successRatePct,
    required this.firstFlight,
    required this.country,
    required this.company,
    required this.wikipedia,
    required this.description,
    required this.id,
  });

  static fromDocument(dynamic json) {
    return SpaceXRocket(
      height: json['height'],
      diameter: json['diameter'],
      mass: json['mass'],
      firstStage: json['first_stage'],
      secondStage: json['second_stage'],
      engines: json['engines'],
      landingLegs: json['landing_legs'],
      payloadWeights: json['payload_weights'],
      flickrImages: json['flickr_images'],
      name: json['name'],
      type: json['type'],
      active: json['active'],
      stages: json['stages'],
      boosters: json['boosters'],
      costPerLaunchaunch: json['cost_per_launch'],
      successRatePct: json['success_rate_pct'],
      firstFlight: json['first_flight'],
      country: json['country'],
      company: json['company'],
      wikipedia: json['wikipedia'],
      description: json['description'],
      id: json['id'],
    );
  }
}
