import 'app_config.dart';

class StagingConfig implements AppConfig {
  static final StagingConfig _singleton = StagingConfig._internal();

  factory StagingConfig() {
    return _singleton;
  }

  StagingConfig._internal();

  @override
  String get apiUrl => 'https://localhost:5001/api/v1';

  @override
  String get name => 'staging';
}
