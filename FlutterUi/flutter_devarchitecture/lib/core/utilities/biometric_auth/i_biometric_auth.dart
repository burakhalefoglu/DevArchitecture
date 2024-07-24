abstract class IBiometricAuth {
  Future<bool> canCheckBiometrics();
  Future<List<CustomBiometricType>> getAvailableBiometrics();
  Future<bool> authenticate({required String localizedReason});
}

enum CustomBiometricType {
  fingerprint,
  face,
  iris,
}
