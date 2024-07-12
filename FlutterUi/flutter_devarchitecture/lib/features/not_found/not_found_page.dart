import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/dependency_resolvers/get_it/core_initializer.dart';
import '../layouts/base_scaffold.dart';
import '/core/theme/extensions.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(
        context,
        Center(
            child: SizedBox(
                height: context.percent70Screen,
                width: context.percent70Screen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: CoreInitializer()
                            .coreContainer
                            .animationAsset
                            .get404AnimationAsset(context.percent75Screen,
                                context.percent75Screen)),
                  ],
                ))),
        isDrawer: false);
  }
}
