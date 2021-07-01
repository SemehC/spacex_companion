import 'package:flutter/material.dart';

class FancyCard extends StatelessWidget {
  const FancyCard({
    Key? key,
    required this.image,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final Image image;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
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
            Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
            OutlineButton(
              child: const Text("Learn more"),
              onPressed: () => onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
