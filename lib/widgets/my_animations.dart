import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyAnimations {
  static rocketInSpace() {
    return LottieBuilder.asset(
      "assets/lottie/rocket_loading.json",
    );
  }

  static noImagesAnimation() {
    return Column(
      children: [
        LottieBuilder.asset(
          "assets/lottie/space_panda_and_turtle.json",
        ),
        Text("No images found",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }

  static noVideosFound() {
    return Column(
      children: [
        LottieBuilder.asset(
          "assets/lottie/404_space_error.json",
        ),
        Text("No Video stream yet",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }

  static rocketStillInPreparation() {
    return Column(
      children: [
        Text("rocket launch still in preparation",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        LottieBuilder.asset(
          "assets/lottie/astronaut_calculation.json",
        ),
      ],
    );
  }

  static rocketHasBeenLaunched() {
    return Column(
      children: [
        Text("rocket launched",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        LottieBuilder.asset(
          "assets/lottie/space_shuttle_icon.json",
        ),
      ],
    );
  }
}
