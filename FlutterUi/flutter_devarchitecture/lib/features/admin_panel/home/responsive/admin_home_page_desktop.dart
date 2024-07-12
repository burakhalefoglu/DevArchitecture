import 'package:flutter/material.dart';
import '../../../layouts/base_scaffold.dart';

class AdminHomePageDesktop extends StatelessWidget {
  const AdminHomePageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(
      context,
      const Center(
        child: Text("AdminHomePageDesktop"),
      ),
    );
  }
}
