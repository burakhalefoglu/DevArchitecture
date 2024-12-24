import 'package:flutter/material.dart';
import '/core/helpers/translate_provider_extension.dart';

abstract class BaseConstants {
  late BuildContext context;

  BaseConstants(this.context);

  String translate(String key) => context.translationProvider.translate(key);
}

abstract class MessageConstantsBase extends BaseConstants {
  MessageConstantsBase(BuildContext context) : super(context);
}

abstract class ScreenConstantsBase extends BaseConstants {
  ScreenConstantsBase(BuildContext context) : super(context);
}

abstract class SidebarConstantsBase extends BaseConstants {
  SidebarConstantsBase(BuildContext context) : super(context);
}
