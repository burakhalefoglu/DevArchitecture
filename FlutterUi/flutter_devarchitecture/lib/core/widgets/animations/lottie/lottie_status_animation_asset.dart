import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../i_status_animation_asset.dart';

class LottieStatusAnimationAsset implements IStatusAnimationAsset {
  @override
  Widget getLoadingAnimationAsset(double width, double height) {
    return Lottie.asset('assets/animations/lottie/loading.json',
        width: width, height: height);
  }

  @override
  Widget getSendingAnimationAsset(double width, double height) {
    return Lottie.asset('assets/animations/lottie/sending.json',
        width: width, height: height);
  }

  @override
  Widget getSuccessAnimationAsset(double width, double height) {
    return Lottie.asset('assets/animations/lottie/success.json',
        width: width, height: height);
  }

  @override
  Widget getErrorAnimationAsset(double width, double height) {
    return Lottie.asset('assets/animations/lottie/error.json',
        width: width, height: height);
  }

  @override
  Widget getCheckingAnimationAsset(double width, double height) {
    return Lottie.asset('assets/animations/lottie/checking.json',
        width: width, height: height);
  }
}
