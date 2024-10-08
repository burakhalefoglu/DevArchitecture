import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/helpers/translation_provider.dart';

mixin TranslationProviderMixin<T extends StatefulWidget> on State<T> {
  TranslationProvider get translationProvider =>
      Provider.of<TranslationProvider>(context, listen: false);
}
