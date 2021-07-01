import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_button/group_button.dart';
import 'package:ndialog/ndialog.dart';
import 'package:spacex_companion/models/spacex_launch.dart';
import 'package:spacex_companion/pages/launches/single_launch_page.dart';
import 'package:spacex_companion/services/api_client.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import 'package:swipe/swipe.dart';

class LaunchesPage extends StatefulWidget {
  LaunchesPage({Key? key}) : super(key: key);

  @override
  _LaunchesPageState createState() => _LaunchesPageState();
}

class _LaunchesPageState extends State<LaunchesPage>
    with AutomaticKeepAliveClientMixin {
  bool _fetchedItems = false;

  List<Widget> _allLaunchesCards = [];
  List<Widget> _upcomingLaunchesCards = [];
  List<Widget> _pastLaunchesCards = [];
  List<Widget> _onScreenLaunches = [];
  int _sortingMode = 0;
  List<String> _sortingButtons = [
    "All launches",
    "Upcoming launches",
    "Past launches"
  ];
  int _currentPageNbr = 0;
  int maxPages = 0;

  /*
    0 ==> All launches
    1 ==> Upcoming launches
    2 ==> Previous launches
   */
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchLaunches();
    });
  }

  buildSingleCard(Image image, String title, SpaceXLaunch launch) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 250,
              height: 250,
              child: image,
            ),
            ListTile(
              leading: launch.upcoming
                  ? Icon(
                      FontAwesomeIcons.rocket,
                      color: Colors.red,
                    )
                  : Icon(FontAwesomeIcons.rocket, color: Colors.green),
              title: Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            OutlineButton(
              child: const Text("More info"),
              onPressed: () {
                pressedLaunch(launch);
              },
            ),
          ],
        ),
      ),
    );
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

  pressedLaunch(SpaceXLaunch launch) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SingleLaunchPage(launch: launch)));
  }

  Widget buildLaunchCard(SpaceXLaunch launch) {
    var flImgs = launch.links['flickr']['original'] as List<dynamic>;
    if (launch.links['patch']['large'] != null) {
      return buildSingleCard(buildImageWidget(launch.links['patch']['large']),
          launch.name, launch);
    } else if (launch.links['patch']['small'] != null) {
      return buildSingleCard(buildImageWidget(launch.links['patch']['small']),
          launch.name, launch);
    } else if (flImgs.length != 0) {
      return (buildSingleCard(
          buildImageWidget(flImgs[0]), launch.name, launch));
    } else {
      return buildSingleCard(
          buildImageWidget("", imgType: 1), launch.name, launch);
    }
  }

  fetchUpcomingLaunches() async {
    _upcomingLaunchesCards = [];
    List<SpaceXLaunch> launches = await APIClient.getUpcomingLaunches();
    for (int i = 0; i < launches.length; i++) {
      _upcomingLaunchesCards.add(buildLaunchCard(launches[i]));
    }

    maxPages = (launches.length / 10).floor();
    _currentPageNbr = 0;
    buildOnScreenWidgets();
  }

  fetchPreviousLaunches() async {
    setState(() {
      _fetchedItems = false;
    });
    _pastLaunchesCards = [];
    List<SpaceXLaunch> launches = await APIClient.getPreviousLaunches();
    for (int i = 0; i < launches.length; i++) {
      _pastLaunchesCards.add(buildLaunchCard(launches[i]));
    }

    maxPages = (launches.length / 10).floor();

    _currentPageNbr = 0;
    buildOnScreenWidgets();
  }

  fetchLaunches() async {
    setState(() {
      _fetchedItems = false;
    });
    _allLaunchesCards = [];
    List<SpaceXLaunch> launches = await APIClient.getAllLaunches();
    for (int i = 0; i < launches.length; i++) {
      _allLaunchesCards.add(buildLaunchCard(launches[i]));
    }
    maxPages = (launches.length / 10).floor();

    _currentPageNbr = 0;
    buildOnScreenWidgets();
  }

  buildOnScreenWidgets() {
    List<Widget> dipLaunches = [];
    if (_sortingMode == 0) {
      if (_allLaunchesCards.length < (_currentPageNbr * 10) + 10) {
        dipLaunches = _allLaunchesCards.sublist(
            _currentPageNbr * 10, _allLaunchesCards.length);
      } else {
        dipLaunches = _allLaunchesCards.sublist(
            _currentPageNbr * 10, (_currentPageNbr + 1) * 10);
      }
    }

    if (_sortingMode == 1) {
      if (_upcomingLaunchesCards.length < (_currentPageNbr * 10) + 10) {
        dipLaunches = _upcomingLaunchesCards.sublist(
            _currentPageNbr * 10, _upcomingLaunchesCards.length);
      } else {
        dipLaunches = _upcomingLaunchesCards.sublist(
            _currentPageNbr * 10, (_currentPageNbr + 1) * 10);
      }
    }

    if (_sortingMode == 2) {
      if (_pastLaunchesCards.length < (_currentPageNbr * 10) + 10) {
        dipLaunches = _pastLaunchesCards.sublist(
            _currentPageNbr * 10, _pastLaunchesCards.length);
      } else {
        dipLaunches = _pastLaunchesCards.sublist(
            _currentPageNbr * 10, (_currentPageNbr + 1) * 10);
      }
    }
    _onScreenLaunches = [];

    setState(() {
      _onScreenLaunches = dipLaunches;
      _fetchedItems = true;
    });
  }

  buildOnScreenLaunchesCarousel() {
    return Container(
      child: StackedCardCarousel(
        items: _onScreenLaunches,
        type: StackedCardCarouselType.fadeOutStack,
      ),
    );
  }

  showOptionsDialog() async {
    await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text("SpaceX Launches Settings"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GroupButton(
            isRadio: true,
            spacing: 10,
            onSelected: (index, isSelected) async {
              if (index == 0) {
                await fetchLaunches();
              } else if (index == 1) {
                await fetchUpcomingLaunches();
              } else {
                await fetchPreviousLaunches();
              }
              setState(() {
                _currentPageNbr = 0;
                _sortingMode = index;
                buildOnScreenWidgets();
              });
              Navigator.pop(context);
            },
            selectedButton: _sortingMode,
            buttons: _sortingButtons,
          )
        ],
      ),
    ).show(context, transitionType: DialogTransitionType.Bubble);
  }

  buildAppBar() {
    return AppBar(
      title: const Text('SpaceX Launches'),
      actions: [
        TextButton.icon(
            onPressed: showOptionsDialog,
            icon: Icon(Icons.sort),
            label: Text("Sort"))
      ],
    );
  }

  nextPage() {
    if (_sortingMode == 0) {
      if (_currentPageNbr * 10 < _allLaunchesCards.length) {
        _currentPageNbr++;
        buildOnScreenWidgets();
      } else {}
    }

    if (_sortingMode == 1) {
      if (_currentPageNbr * 10 < _upcomingLaunchesCards.length) {
        _currentPageNbr++;
        buildOnScreenWidgets();
      } else {}
    }

    if (_sortingMode == 2) {
      if (_currentPageNbr * 10 < _pastLaunchesCards.length) {
        _currentPageNbr++;
        buildOnScreenWidgets();
      } else {}
    }
  }

  prevPage() {
    if (_currentPageNbr > 0) {
      _currentPageNbr--;
      buildOnScreenWidgets();
    }
  }

  onRightSwipe() {
    prevPage();
  }

  onLeftSwipe() {
    nextPage();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: _fetchedItems
          ? Swipe(
              onSwipeLeft: nextPage,
              onSwipeRight: prevPage,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          prevPage();
                        },
                        icon: Icon(Icons.first_page_rounded),
                        label: Text("Previous"),
                      ),
                      Text("Page ${_currentPageNbr + 1}/${maxPages + 1}"),
                      TextButton.icon(
                        onPressed: () {
                          nextPage();
                        },
                        icon: Icon(Icons.last_page_rounded),
                        label: Text("Next"),
                      ),
                    ],
                  ),
                  ..._onScreenLaunches,
                ],
              ),
            )
          : const Text("Loading"),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
