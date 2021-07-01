import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ndialog/ndialog.dart';
import 'package:spacex_companion/models/spacex_capsule.dart';
import 'package:spacex_companion/models/spacex_launch.dart';
import 'package:spacex_companion/models/spacex_launchpad.dart';
import 'package:spacex_companion/models/spacex_payload.dart';
import 'package:spacex_companion/models/spacex_rocket.dart';
import 'package:spacex_companion/pages/display_web_page.dart';
import 'package:spacex_companion/services/api_client.dart';
import 'package:spacex_companion/widgets/my_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleLaunchGeneralInfo extends StatefulWidget {
  SingleLaunchGeneralInfo({Key? key, required this.launch}) : super(key: key);

  final SpaceXLaunch launch;

  @override
  _SingleLaunchGeneralInfoState createState() =>
      _SingleLaunchGeneralInfoState();
}

class _SingleLaunchGeneralInfoState extends State<SingleLaunchGeneralInfo>
    with AutomaticKeepAliveClientMixin {
  SpaceXRocket? _rocket = null;
  SpaceXLaunchPad? _launchPad = null;
  List<SpaceXPayload> _payloads = [];
  List<SpaceXCapsule> _capsules = [];

  List<Widget> _payloadsWidgets = [];
  bool _loadedPyloadWidgets = false;
  List<Widget> _capsulesWidgets = [];
  bool _loadedCapsulesWidgets = false;

  bool _launchState = false;
  bool _succState = false;

  @override
  void initState() {
    super.initState();
    initRocketInfo();
    fetchRocketInfos();
    buildPayloadsInfo();
    buildCapsulesInfos();
  }

  fetchRocketInfos() async {
    _rocket = await APIClient.getRocketById(widget.launch.rocket);
    _launchPad = await APIClient.getLaunchPadById(widget.launch.launchpad);
  }

  initRocketInfo() {
    setState(() {
      _launchState = widget.launch.success != -1 ? true : false;
      _succState = widget.launch.success == 1 ? true : false;
    });
  }

  pressedOnLink(String name, String link) {
    print("Pressed page $name : Link : $link ");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayWebPage(pageName: name, link: link)));
  }

  buildExternalLinks() {
    String _article = widget.launch.links['article'] != null
        ? widget.launch.links['article']
        : "";
    String _wikipedia = widget.launch.links['wikipedia'] != null
        ? widget.launch.links['wikipedia']
        : "";
    print(_article);
    return Column(
      children: [
        _article != ""
            ? TextButton.icon(
                onPressed: () => pressedOnLink("Article", _article),
                icon: Icon(Icons.article),
                label: Text("Article"))
            : Text(""),
        _wikipedia != ""
            ? TextButton.icon(
                onPressed: () async {
                  launch(_wikipedia);
                },
                icon: Icon(FontAwesomeIcons.wikipediaW),
                label: Text("Wikipedia"))
            : Text(""),
      ],
    );
  }

  buildUTCLaunchTime() {
    String utcDateString =
        "Launch time : ${widget.launch.dateUTC.year}-${widget.launch.dateUTC.month}-${widget.launch.dateUTC.day}";
    String utcDateSub = "UTC launch time";
    return ListTile(
      title: Text(utcDateString),
      subtitle: Text(utcDateSub),
      leading: Icon(FontAwesomeIcons.rocket),
    );
  }

  buildFlightNumber() {
    String _flightNbr = "Flight number : ${widget.launch.flightNumber}";
    return ListTile(
      title: Text(_flightNbr),
      leading: Icon(Icons.confirmation_number_outlined),
    );
  }

  buildRocketInfoPopup() async {
    await NDialog(
      title: Text(_rocket!.name),
      content: Text(_rocket!.description),
      actions: [
        TextButton.icon(
          onPressed: () => print("test"),
          icon: Icon(Icons.info),
          label: Text("More info"),
        ),
      ],
    ).show(context, transitionType: DialogTransitionType.Bubble);
  }

  buildRocketInfo() {
    return ListTile(
      onTap: buildRocketInfoPopup,
      title: Text(_rocket!.name),
      subtitle: Text("Rocket"),
      leading: Icon(FontAwesomeIcons.rocket),
    );
  }

  buildSuccessInfo() {
    String successInfo = _succState ? "Success" : "Failure";
    if (_launchState) {
      return ListTile(
        title: Text("Rocket launch is a $successInfo"),
        leading: Icon(FontAwesomeIcons.rocket,
            color: _succState ? Colors.green : Colors.red),
      );
    } else {
      return ListTile(
          title: Text("Rocket is not launched yet"),
          leading: Icon(FontAwesomeIcons.rocket,
              color: _succState ? Colors.green : Colors.orange));
    }
  }

  buildLaunchPadInfoPopup() async {
    await NDialog(
      title: Text(_launchPad!.name),
      content: Text(_launchPad!.fullName),
      actions: [
        TextButton.icon(
          onPressed: () => print("test"),
          icon: Icon(Icons.info),
          label: Text("More info"),
        ),
      ],
    ).show(context, transitionType: DialogTransitionType.Bubble);
  }

  buildLaunchPadInfo() {
    return ListTile(
      title: Text("Launchpad : ${_launchPad!.name}"),
      leading: Icon(LineIcons.rocket),
      onTap: buildLaunchPadInfoPopup,
    );
  }

  buildPayloadInfoPopup(SpaceXPayload payload) async {
    await NDialog(
      title: Text(payload.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(FontAwesomeIcons.satellite),
            title: Text(payload.type),
            subtitle: Text("Payload type"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.weight),
            title: Text(payload.massKg.toString()),
            subtitle: Text("Payload Mass in kg"),
          ),
          ListTile(
            leading: Icon(LineIcons.fly),
            title: Text(payload.regime),
            subtitle: Text("Payload orbit regime"),
          ),
        ],
      ),
      actions: [
        TextButton.icon(
            onPressed: () => print("More infs"),
            icon: Icon(Icons.info),
            label: Text("More info"))
      ],
    ).show(context, transitionType: DialogTransitionType.Bubble);
  }

  buildPayloadsInfo() async {
    List<SpaceXPayload> l =
        await APIClient.getListOfPayloads(widget.launch.payloads);
    List<Widget> tiles = [];
    for (int i = 0; i < l.length; i++) {
      var element = l[i];
      tiles.add(
        ListTile(
          title: Text(element.name),
          subtitle: Text("Payload"),
          leading: Icon(FontAwesomeIcons.luggageCart),
          onTap: () => {buildPayloadInfoPopup(element)},
        ),
      );
    }

    setState(() {
      _payloadsWidgets = tiles;
      _loadedPyloadWidgets = true;
      print("Loaded payloads : ${_payloadsWidgets.length}");
    });
  }

  buildCapsulesInfoPopup(SpaceXCapsule capsule) async {
    await NDialog(
      title: Text(capsule.type),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(FontAwesomeIcons.satellite),
            title: Text(capsule.type),
            subtitle: Text("Capsule type"),
          ),
          ListTile(
            leading: Icon(Icons.restart_alt_rounded),
            title: Text(capsule.reuseCount.toString()),
            subtitle: Text("Capsule reuse count"),
          ),
        ],
      ),
      actions: [
        TextButton.icon(
            onPressed: () => print("More infs"),
            icon: Icon(Icons.info),
            label: Text("More info"))
      ],
    ).show(context, transitionType: DialogTransitionType.Bubble);
  }

  buildCapsulesInfos() async {
    List<SpaceXCapsule> l =
        await APIClient.getListOfCapsules(widget.launch.capsules);
    List<Widget> tiles = [];
    for (int i = 0; i < l.length; i++) {
      var element = l[i];
      tiles.add(
        ListTile(
          title: Text(element.type),
          subtitle: Text("Capsule type"),
          leading: Icon(FontAwesomeIcons.luggageCart),
          onTap: () => {buildCapsulesInfoPopup(element)},
        ),
      );
    }

    setState(() {
      _capsulesWidgets = tiles;
      _loadedCapsulesWidgets = true;
      print("Loaded capsules : ${_capsulesWidgets.length}");
    });
  }

  buildMainPage() {
    return ListView(
      children: [
        buildExternalLinks(),
        buildUTCLaunchTime(),
        buildFlightNumber(),
        _rocket != null ? buildRocketInfo() : Text(""),
        buildSuccessInfo(),
        _launchPad != null ? buildLaunchPadInfo() : Text(""),
        _payloadsWidgets.length != 0
            ? Row(children: <Widget>[
                Expanded(child: Divider()),
                Text("Payloads"),
                Expanded(child: Divider()),
              ])
            : Text(""),
        if (_loadedPyloadWidgets) ..._payloadsWidgets else Text(""),
        _capsulesWidgets.length != 0
            ? Row(children: <Widget>[
                Expanded(child: Divider()),
                Text("Capsules"),
                Expanded(child: Divider()),
              ])
            : Text(""),
        if (_loadedCapsulesWidgets) ..._capsulesWidgets else Text(""),
        !_launchState
            ? MyAnimations.rocketStillInPreparation()
            : MyAnimations.rocketHasBeenLaunched(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return (_loadedPyloadWidgets && _loadedCapsulesWidgets)
        ? buildMainPage()
        : MyAnimations.rocketInSpace();
  }

  @override
  bool get wantKeepAlive => true;
}
