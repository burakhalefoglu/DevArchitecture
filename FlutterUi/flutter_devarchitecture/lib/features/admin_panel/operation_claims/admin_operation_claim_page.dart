import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/features/layouts/base_scaffold.dart';

class AdminOperationClaimPage extends StatelessWidget {
  const AdminOperationClaimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(
        context,
        const Center(
          child: Text("Admin OperationClaim Page"),
        ));
  }
}
