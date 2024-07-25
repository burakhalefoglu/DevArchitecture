import 'dev_config.dart';
import 'prod_config.dart';
import 'staging_config.dart';

abstract class AppConfig {
  String get apiUrl;
  String get name;
}

//? flutter build web --dart-define ENV=staging --web-renderer html --release
//? flutter build apk --dart-define ENV=prod --release
//? flutter run --dart-define ENV=dev --release
//? flutter run --dart-define ENV=staging --release
//? flutter run --dart-define ENV=prod --release

//? flutter run --dart-define ENV=prod --dart-define=FIREBASE=true

AppConfig getConfig() {
  const environmentParameter = String.fromEnvironment('ENV');
  switch (environmentParameter) {
    case 'dev':
      return DevConfig();
    case 'staging':
      return StagingConfig();
    case 'prod':
      return ProdConfig();
    default:
      return DevConfig();
  }
}

var appConfig = getConfig();
