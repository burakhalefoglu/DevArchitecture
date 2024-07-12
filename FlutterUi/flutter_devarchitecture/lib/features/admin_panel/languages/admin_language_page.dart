import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/features/layouts/base_scaffold.dart';

class AdminLanguagePage extends StatelessWidget {
  const AdminLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(
        context,
        const Center(
          child: Text("Admin Language Page"),
        ));
  }
}
