import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/di/core_initializer.dart';
import 'package:flutter_devarchitecture/core/utilities/internet_connection/i_internet_connection.dart';

import '../../../features/layouts/base_scaffold.dart';

class InternetConnectionPage extends StatefulWidget {
  @override
  _InternetConnectionPageState createState() => _InternetConnectionPageState();
}

class _InternetConnectionPageState extends State<InternetConnectionPage> {
  late IInternetConnection _internetConnection;

  @override
  void initState() {
    super.initState();
    _internetConnection = CoreInitializer().coreContainer.internetConnection;

    // İnternet bağlantısını dinlemeye başla
    _internetConnection
        .listenConnection(CoreInitializer().coreContainer.screenMessage);
  }

  @override
  void dispose() {
    // Dinlemeyi durdur
    _internetConnection.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(
      context,
      _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _checkConnection,
        child: Text('Bağlantıyı Kontrol Et'),
      ),
    );
  }

  void _checkConnection() async {
    bool isConnected = await _internetConnection.isConnected();
    String message = isConnected
        ? "İnternet bağlantısı mevcut."
        : "İnternet bağlantısı yok!";
    CoreInitializer().coreContainer.screenMessage.getInfoMessage(message);
  }
}
