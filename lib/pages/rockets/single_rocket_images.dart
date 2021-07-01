import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ndialog/ndialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spacex_companion/models/spacex_rocket.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class SingleRocketImages extends StatefulWidget {
  SingleRocketImages({Key? key, required this.rocket}) : super(key: key);
  final SpaceXRocket rocket;

  @override
  _SingleRocketImagesState createState() => _SingleRocketImagesState();
}

class _SingleRocketImagesState extends State<SingleRocketImages> {
  List<Widget> _flickerCards = [];
  bool _loadedImages = false;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  fetchImages() {
    String rocketName = "${widget.rocket.name}_${widget.rocket.id}";
    for (var i = 0; i < widget.rocket.flickrImages.length; i++) {
      String el = widget.rocket.flickrImages[i];

      _flickerCards.add(buildSingleCard(rocketName, el, i));
    }

    setState(() {
      _loadedImages = true;
    });
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
    String imgName =
        "${widget.rocket.name.replaceAll(" ", "_")}_${title}_$imgNbr";
    bool exists =
        await File("storage/emulated/0/Pictures/$imgName.jpg").exists();
    await NDialog(
      title: Text(widget.rocket.name),
      content: Image(image: CachedNetworkImageProvider(imgLink)),
      actions: [
        TextButton.icon(
            onPressed: () {
              saveImageToLocal(
                imgLink,
                imgName,
              );
            },
            icon:
                exists ? Icon(Icons.downloading_rounded) : Icon(Icons.download),
            label: exists
                ? Text("Redownload (overwrite previous)")
                : Text("Save image"))
      ],
    ).show(context, transitionType: DialogTransitionType.Bubble);
  }

  saveImageToLocal(String imgLink, String imgName) async {
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
      Fluttertoast.showToast(msg: "Image saved");
    } else {
      Permission.storage.request();
    }
  }

  buildAppBar() {
    return AppBar(
      title: Text("${widget.rocket.name} images"),
    );
  }

  buildFlickrImages() {
    return StackedCardCarousel(
      items: _flickerCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: _loadedImages ? buildFlickrImages() : Text("Loading"),
    );
  }
}
