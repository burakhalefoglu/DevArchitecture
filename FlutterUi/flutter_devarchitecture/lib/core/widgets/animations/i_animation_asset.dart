import 'package:flutter/material.dart';

abstract class IAnimationAsset {
  Widget get404AnimationAsset(double width, double height);
  Widget getLoadingAnimationAsset(double width, double height);
  Widget getCheckingAnimationAsset(double width, double height);
  Widget getSendingAnimationAsset(double width, double height);
  Widget getErrorAnimationAsset(double width, double height);
  Widget getSuccessAnimationAsset(double width, double height);
}
