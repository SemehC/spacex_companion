import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spacex_companion/models/spacex_rocket.dart';
import 'package:url_launcher/url_launcher.dart';

class SingelRocketGeneralInfo extends StatefulWidget {
  SingelRocketGeneralInfo({Key? key, required this.rocket}) : super(key: key);

  final SpaceXRocket rocket;

  @override
  _SingelRocketGeneralInfoState createState() =>
      _SingelRocketGeneralInfoState();
}

class _SingelRocketGeneralInfoState extends State<SingelRocketGeneralInfo> {
  final lengthUnits = ['meters', 'feet'];
  final massUnits = ['kg', 'lb'];
  buildExternalLinks() {
    String _wikipedia = widget.rocket.wikipedia;
    return Column(
      children: [
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

  int _heightParam = 0;
  int _diamaterParam = 0;
  int _massParam = 0;
  buildRocketHeight() {
    return ListTile(
      leading: Icon(Icons.height),
      title: Text(widget.rocket.height[lengthUnits[_heightParam]].toString()),
      trailing: TextButton.icon(
        onPressed: () {
          setState(() {
            _heightParam == 0 ? _heightParam = 1 : _heightParam = 0;
          });
        },
        icon: Icon(Icons.change_circle_outlined),
        label: Text("Change"),
      ),
      subtitle: Text(_heightParam == 0 ? "Height in meters" : "Height in feet"),
    );
  }

  buildRocketDiamater() {
    return ListTile(
      leading: Icon(Icons.height),
      title:
          Text(widget.rocket.diameter[lengthUnits[_diamaterParam]].toString()),
      trailing: TextButton.icon(
        onPressed: () {
          setState(() {
            _diamaterParam == 0 ? _diamaterParam = 1 : _diamaterParam = 0;
          });
        },
        icon: Icon(Icons.change_circle_outlined),
        label: Text("Change"),
      ),
      subtitle:
          Text(_diamaterParam == 0 ? "Diamater in meters" : "Diamater in feet"),
    );
  }

  buildRocketMass() {
    return ListTile(
      leading: Icon(Icons.masks_sharp),
      title: Text(widget.rocket.mass[massUnits[_massParam]].toString()),
      trailing: TextButton.icon(
        onPressed: () {
          setState(() {
            _massParam == 0 ? _massParam = 1 : _massParam = 0;
          });
        },
        icon: Icon(Icons.change_circle_outlined),
        label: Text("Change"),
      ),
      subtitle: Text(_massParam == 0 ? "Mass in kg" : "Mass in lb"),
    );
  }

  buildRocketStages() {
    return ListTile(
      leading: Icon(Icons.storage),
      title: Text("Total stages : ${widget.rocket.stages}"),
    );
  }

  buildRocketSuccessRate() {
    return ListTile(
      leading: Icon(Icons.storage),
      title: Text("Success rate : ${widget.rocket.successRatePct}%"),
    );
  }

  buildRocketDescription() {
    return ListTile(
        leading: Icon(Icons.description),
        title: Text(widget.rocket.description));
  }

  buildAdditionalDetails() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.flag),
          title: Text("Country : ${widget.rocket.country}"),
        ),
        ListTile(
          leading: Icon(Icons.flag),
          title: Text("Cost per launch : ${widget.rocket.costPerLaunchaunch}"),
        ),
        ListTile(
          leading: Icon(Icons.flag),
          title: Text("Company : ${widget.rocket.company}"),
        ),
      ],
    );
  }

  buildRocketActiveState() {
    bool rocketState = widget.rocket.active;
    return ListTile(
      leading: Icon(FontAwesomeIcons.rocket),
      title: Text(rocketState ? "Rocket is active" : "Rocket is inactive"),
    );
  }

  buildAppBar() {
    return AppBar(
      title: Text("${widget.rocket.name} General info"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        children: [
          buildExternalLinks(),
          buildRocketDescription(),
          buildRocketHeight(),
          buildRocketDiamater(),
          buildRocketMass(),
          buildRocketStages(),
          buildRocketSuccessRate(),
          buildRocketActiveState(),
          buildAdditionalDetails(),
        ],
      ),
    );
  }
}
