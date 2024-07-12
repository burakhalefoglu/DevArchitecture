import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/features/layouts/base_scaffold.dart';

class AdminUserPage extends StatelessWidget {
  const AdminUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(
        context,
        const Center(
          child: Text("Admin User Page"),
        ));
  }
}
