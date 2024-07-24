import 'package:flutter/widgets.dart';
import 'package:flutter_devarchitecture/core/widgets/animations/i_animation_asset.dart';

abstract class IInteractionAnimationAsset extends IAnimationAsset {
  Widget getFeedbackAnimationAsset(double width, double height);
}
