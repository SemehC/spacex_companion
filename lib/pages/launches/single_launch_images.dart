import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ndialog/ndialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spacex_companion/models/spacex_launch.dart';
import 'package:spacex_companion/widgets/my_animations.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class SingleLaunchImages extends StatefulWidget {
  SingleLaunchImages({Key? key, required this.launch}) : super(key: key);

  final SpaceXLaunch launch;

  @override
  _SingleLaunchImagesState createState() => _SingleLaunchImagesState();
}

class _SingleLaunchImagesState extends State<SingleLaunchImages>
    with AutomaticKeepAliveClientMixin {
  List<Widget> _patchesCards = [];
  List<Widget> _flickerCards = [];

  @override
  void initState() {
    super.initState();
    fetchPatchesLinks();
    fetchFlickrImages();
  }

  buildSingleCard(String title, String imageLink, int imgNbr) {
    return GestureDetector(
      onTap: () {
        imageTappedPopup(title, imageLink, imgNbr);
      },
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 250,
                height: 250,
                child: Image(
                  image: CachedNetworkImageProvider(imageLink),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  imageTappedPopup(String title, String imgLink, int imgNbr) async {
    await NDialog(
      title: Text(title),
      content: Image(image: CachedNetworkImageProvider(imgLink)),
      actions: [
        TextButton.icon(
            onPressed: () {
              saveImageToLocal(imgLink,
                  "${widget.launch.name.replaceAll(" ", "_")}_${title}_$imgNbr");
            },
            icon: Icon(Icons.download),
            label: Text("Save image"))
      ],
    ).show(context, transitionType: DialogTransitionType.Bubble);
  }

  fetchPatchesLinks() async {
    if (widget.launch.links['patch']['large'] != null) {
      _patchesCards.add(
          buildSingleCard("Patch", widget.launch.links['patch']['large'], 0));
    } else {
      if (widget.launch.links['patch']['small'] != null) {
        _patchesCards.add(
            buildSingleCard("Patch", widget.launch.links['patch']['small'], 0));
      }
    }
    setState(() {});
  }

  fetchFlickrImages() async {
    var flImgs = widget.launch.links['flickr']['original'] as List<dynamic>;
    for (int i = 0; i < flImgs.length; i++) {
      _flickerCards.add(buildSingleCard("Image", flImgs[i], i));
    }
    setState(() {});
  }

  PageController patchController = PageController();
  PageController flickrController = PageController();
  buildPatchImage() {
    return StackedCardCarousel(
      items: _patchesCards,
      pageController: patchController,
    );
  }

  buildFlickrImages() {
    return StackedCardCarousel(
      items: _flickerCards,
      pageController: flickrController,
    );
  }

  saveImageToLocal(String imgLink, String imgName) async {
    if (await File("storage/emulated/0/Pictures/$imgName.jpg").exists()) {
      Fluttertoast.showToast(msg: "File already exists");
    } else {
      Permission.storage.request();
      if (await Permission.storage.request().isGranted) {
        var response = await Dio()
            .get(imgLink, options: Options(responseType: ResponseType.bytes));
        print(response.headers);
        final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          name: imgName,
          quality: 100,
        );
        print(result);
      } else {
        Permission.storage.request();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Patch",
                ),
                Tab(
                  text: "Images",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _patchesCards.length != 0
                ? buildPatchImage()
                : MyAnimations.noImagesAnimation(),
            _flickerCards.length != 0
                ? buildFlickrImages()
                : MyAnimations.noImagesAnimation()
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
