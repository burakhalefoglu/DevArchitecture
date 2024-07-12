import 'package:flutter/material.dart';
import '../../../layouts/base_scaffold.dart';

class HomePageDesktop extends StatelessWidget {
  const HomePageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(
      context,
      const Center(
        child: Text("HomePageDesktop"),
      ),
    );
  }
}
