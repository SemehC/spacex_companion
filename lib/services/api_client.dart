import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:spacex_companion/models/spacex_capsule.dart';
import 'package:spacex_companion/models/spacex_launch.dart';
import 'package:spacex_companion/models/spacex_launchpad.dart';
import 'package:spacex_companion/models/spacex_payload.dart';
import 'package:spacex_companion/models/spacex_rocket.dart';

class APIClient {
  //Capsules
  static final String _getAllCapsulesLink =
      "https://api.spacexdata.com/v4/capsules";
  static final String _getSingleCapusleLink =
      "https://api.spacexdata.com/v4/capsules/";

  //Company Info
  static final String _getCompanyInfoLink =
      "https://api.spacexdata.com/v4/company";

  //Cores
  static final String _getAllCoresLink = "https://api.spacexdata.com/v4/cores";
  static final String _getSingleCoreLink =
      "https://api.spacexdata.com/v4/cores/:id";

  //Crew
  static final String _getAllCrewMembersLink =
      "https://api.spacexdata.com/v4/crew";
  static final String _getCrewMemberLink =
      "https://api.spacexdata.com/v4/crew/:id";

  //Dragons
  static final String _getAllDragonsLink =
      "https://api.spacexdata.com/v4/dragons";
  static final String _getSingleDragonLink =
      "https://api.spacexdata.com/v4/dragons/:id";

  //LaunchPads
  static final String _getAllLaunchPadsLink =
      "https://api.spacexdata.com/v4/launchpads";
  static final String _getSingleLaunchPadLink =
      "https://api.spacexdata.com/v4/launchpads/";

  //Launches
  static final String _getPastLaunchesLink =
      "https://api.spacexdata.com/v4/launches/past";

  static final String _getUpcomingLaunchesLink =
      "https://api.spacexdata.com/v4/launches/upcoming";

  static final String _getLatestLaunchLink =
      "https://api.spacexdata.com/v4/launches/latest";

  static final String _getNextLaunchLink =
      "https://api.spacexdata.com/v4/launches/next";

  static final String _getAllLaunchesLink =
      "https://api.spacexdata.com/v4/launches";

  static final String _getSingleLaunchLink =
      "https://api.spacexdata.com/v4/launches/:id";

  //Payloads
  static final String _getAllPayloadsLink =
      "https://api.spacexdata.com/v4/payloads";
  static final String _getSinglePayloadLink =
      "https://api.spacexdata.com/v4/payloads/";

  //Fairings
  static final String _getAllFairingsLink =
      "https://api.spacexdata.com/v4/fairings";
  static final String _getSingleFairingLink =
      "https://api.spacexdata.com/v4/fairings/:id";

  //Roadster info
  static final String _getRoadsterInfoLink =
      "https://api.spacexdata.com/v4/roadster";

  //Rockets
  static final String _getAllRocketsLink =
      "https://api.spacexdata.com/v4/rockets";
  static final String _getSingleRocketLink =
      "https://api.spacexdata.com/v4/rockets/";

  //Ships
  static final String _getAllShipsLink = "https://api.spacexdata.com/v4/ships";
  static final String _getSingleShipLink =
      "https://api.spacexdata.com/v4/ships/:id";

  //Starlink
  static final String _getAllStarlinkSatsLink =
      "https://api.spacexdata.com/v4/starlink";
  static final String _getSingleStarlinkSatLink =
      "https://api.spacexdata.com/v4/starlink/:id";

  //History
  static final String _getAllHistoricalEventsLink =
      "https://api.spacexdata.com/v4/history";
  static final String _getSingleHistoricalEventLink =
      "https://api.spacexdata.com/v4/history/:id";

  static Future<List<SpaceXRocket>> getAllRockets() async {
    List<SpaceXRocket> rockets = [];
    var file = await DefaultCacheManager().getSingleFile(_getAllRocketsLink);
    var res = await file.readAsString();
    var json = jsonDecode(res) as List;
    for (var i = 0; i < json.length; i++) {
      rockets.add(SpaceXRocket.fromDocument(json[i]));
    }
    return rockets;
  }

  static Future<List<SpaceXLaunch>> getAllLaunches() async {
    List<SpaceXLaunch> launches = [];
    var file = await DefaultCacheManager().getSingleFile(_getAllLaunchesLink);
    var res = await file.readAsString();
    var json = jsonDecode(res) as List;
    for (var i = 0; i < json.length; i++) {
      launches.add(SpaceXLaunch.fromDocument(json[i]));
    }

    print(launches.length);
    launches.sort((a, b) => a.compareTo(b));
    print(launches.length);
    return launches;
  }

  static Future<List<SpaceXLaunch>> getPreviousLaunches() async {
    List<SpaceXLaunch> launches = [];
    var file = await DefaultCacheManager().getSingleFile(_getPastLaunchesLink);
    var res = await file.readAsString();
    var json = jsonDecode(res) as List;
    for (var i = 0; i < json.length; i++) {
      launches.add(SpaceXLaunch.fromDocument(json[i]));
    }
    print(launches.length);
    launches.sort((a, b) => a.compareTo(b));
    print(launches.length);
    return launches;
  }

  static Future<List<SpaceXLaunch>> getUpcomingLaunches() async {
    List<SpaceXLaunch> launches = [];
    var file =
        await DefaultCacheManager().getSingleFile(_getUpcomingLaunchesLink);
    var res = await file.readAsString();
    var json = jsonDecode(res) as List;
    for (var i = 0; i < json.length; i++) {
      launches.add(SpaceXLaunch.fromDocument(json[i]));
    }
    print(launches.length);
    launches.sort((a, b) => a.compareTo(b));
    print(launches.length);
    return launches;
  }

  static Future<SpaceXLaunch> getLatestLaunch() async {
    var file = await DefaultCacheManager().getSingleFile(_getLatestLaunchLink);
    var res = await file.readAsString();
    var json = jsonDecode(res);
    var t = SpaceXLaunch.fromDocument(json);
    print(t.name);

    return t;
  }

  static Future<SpaceXRocket> getRocketById(String id) async {
    var file =
        await DefaultCacheManager().getSingleFile(_getSingleRocketLink + id);
    var res = await file.readAsString();
    var json = jsonDecode(res);
    var t = SpaceXRocket.fromDocument(json);

    return t;
  }

  static Future<SpaceXLaunchPad> getLaunchPadById(String id) async {
    var file =
        await DefaultCacheManager().getSingleFile(_getSingleLaunchPadLink + id);
    var res = await file.readAsString();
    var json = jsonDecode(res);
    var t = SpaceXLaunchPad.fromDocument(json);

    return t;
  }

  static Future<SpaceXPayload> getPayloadById(String id) async {
    var file =
        await DefaultCacheManager().getSingleFile(_getSinglePayloadLink + id);
    var res = await file.readAsString();
    var json = jsonDecode(res);
    var t = SpaceXPayload.fromDocument(json);
    return t;
  }

  static Future<List<SpaceXPayload>> getListOfPayloads(
      List<dynamic> ids) async {
    List<SpaceXPayload> _payloads = [];
    for (int i = 0; i < ids.length; i++) {
      _payloads.add(await getPayloadById(ids[i]));
    }
    return _payloads;
  }

  static Future<SpaceXCapsule> getCapsuleById(String id) async {
    var file =
        await DefaultCacheManager().getSingleFile(_getSingleCapusleLink + id);
    var res = await file.readAsString();
    var json = jsonDecode(res);
    var t = SpaceXCapsule.fromDocument(json);
    return t;
  }

  static Future<List<SpaceXCapsule>> getListOfCapsules(
      List<dynamic> ids) async {
    List<SpaceXCapsule> _capsules = [];
    for (int i = 0; i < ids.length; i++) {
      _capsules.add(await getCapsuleById(ids[i]));
    }
    return _capsules;
  }
}
