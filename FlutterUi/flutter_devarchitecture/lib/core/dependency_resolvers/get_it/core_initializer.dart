import '/core/dependency_resolvers/get_it/get_it_core_di.dart';

import '../core_di.dart';

class CoreInitializer {
  late ICoreContainer coreContainer;

  static final CoreInitializer _singleton = CoreInitializer._internal();

  factory CoreInitializer() {
    return _singleton;
  }

  CoreInitializer._internal() {
    _init();
  }

  void _init() {
    coreContainer = GetItCoreContainer();
  }
}
