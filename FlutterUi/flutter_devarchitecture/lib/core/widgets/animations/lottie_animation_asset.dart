import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'i_animation_asset.dart';

class LottieAnimationAsset extends IAnimationAsset {
  static final LottieAnimationAsset _singleton =
      LottieAnimationAsset._internal();

  factory LottieAnimationAsset() {
    return _singleton;
  }
  LottieAnimationAsset._internal();

  @override
  Widget get404AnimationAsset(double width, double height) {
    return Lottie.asset('assets/animations/lottie/404.json',
        animate: true, width: width, height: height);
  }

  @override
  Widget getCheckingAnimationAsset(double width, double height) {
    // TODO: implement getCheckingAnimationAsset
    throw UnimplementedError();
  }

  @override
  Widget getErrorAnimationAsset(double width, double height) {
    // TODO: implement getErrorAnimationAsset
    throw UnimplementedError();
  }

  @override
  Widget getLoadingAnimationAsset(double width, double height) {
    // TODO: implement getLoadingAnimationAsset
    throw UnimplementedError();
  }

  @override
  Widget getSendingAnimationAsset(double width, double height) {
    // TODO: implement getSendingAnimationAsset
    throw UnimplementedError();
  }

  @override
  Widget getSuccessAnimationAsset(double width, double height) {
    // TODO: implement getSuccessAnimationAsset
    throw UnimplementedError();
  }
}
