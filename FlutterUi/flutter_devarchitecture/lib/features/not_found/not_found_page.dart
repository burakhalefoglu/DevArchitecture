import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/constants/messages.dart';
import '../../core/constants/screen_element_constants.dart';
import '../../core/di/core_initializer.dart';
import '../../routes/routes_constants.dart';
import '../layouts/base_scaffold.dart';
import '../../core/theme/extensions.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(
        context,
        Center(
            heightFactor: 1,
            child: SizedBox(
                height: context.percent70Screen,
                width: context.percent70Screen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: context.isMobile ? 14 : 17,
                        child: CoreInitializer()
                            .coreContainer
                            .pageAnimationAsset
                            .get404PageAnimationAsset(context.percent80Screen,
                                context.percent75Screen)),
                    Expanded(
                        child: Text(
                      Messages.pageNotFound,
                      style: TextStyle(
                          fontSize: context.isMobile ? 18 : 22,
                          fontWeight: FontWeight.w500),
                    )),
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          Modular.to.navigate(RoutesConstants.appHomePage);
                        },
                        child: Text(ScreenElementConstants.returnHomePage),
                      ),
                    )
                  ],
                ))),
        isDrawer: false);
  }
}
