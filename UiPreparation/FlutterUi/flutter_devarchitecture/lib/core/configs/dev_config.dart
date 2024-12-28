import 'app_config.dart';

class DevConfig implements AppConfig {
  static final DevConfig _singleton = DevConfig._internal();

  factory DevConfig() {
    return _singleton;
  }
  DevConfig._internal();

  @override
  String get apiUrl => 'https://localhost:5001/api/v1'; // Set by backend url
  @override
  String get name => 'dev';
}
