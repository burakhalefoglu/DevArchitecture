import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/core/dependency_resolvers/get_it/core_initializer.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../routes/routes_constants.dart';
import '../../layouts/base_scaffold.dart';
import '/core/theme/extensions.dart';

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
                            .animationAsset
                            .get404AnimationAsset(context.percent80Screen,
                                context.percent75Screen)),
                    Expanded(
                        child: Text(
                      "Ulaşmaya Çalıştığınız Sayfa bulunmamaktadır!",
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
                        child: const Text("Anasayfaya Geri Dön"),
                      ),
                    )
                  ],
                ))),
        isDrawer: false);
  }
}
