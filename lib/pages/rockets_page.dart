import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spacex_companion/models/spacex_rocket.dart';
import 'package:spacex_companion/pages/rockets/single_rocket_page.dart';
import 'package:spacex_companion/services/api_client.dart';

class RocketsPage extends StatefulWidget {
  RocketsPage({Key? key}) : super(key: key);

  @override
  _RocketsPageState createState() => _RocketsPageState();
}

class _RocketsPageState extends State<RocketsPage> {
  bool _loadedRockets = false;
  List<Widget> _rocketsCards = [];

  @override
  void initState() {
    super.initState();
    fetchRockets();
  }

  buildImageWidget(String imgURL, {int imgType = 0}) {
    if (imgType == 0)
      return Image(
        image: CachedNetworkImageProvider(imgURL),
      );
    else {
      return Image.asset("assets/images/spacex_logo.jpg");
    }
  }

  fetchRockets() async {
    var _tmp = await APIClient.getAllRockets();

    _tmp.forEach((element) {
      var img = buildImageWidget(element.flickrImages.first);
      _rocketsCards.add(buildSingleCard(img, element));
    });
    setState(() {
      _loadedRockets = true;
    });
  }

  buildSingleCard(Image img, SpaceXRocket rocket) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 250,
              height: 250,
              child: img,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.rocket,
              ),
              title: Text(
                rocket.name,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            OutlineButton(
              child: const Text("More info"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SingleRocketPage(rocket: rocket)));
              },
            ),
          ],
        ),
      ),
    );
  }

  buildAppBar() {
    return AppBar(
      title: Text("Rockets"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        children: [
          ..._rocketsCards,
        ],
      ),
    );
  }
}
