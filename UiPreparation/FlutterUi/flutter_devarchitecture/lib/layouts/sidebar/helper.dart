import 'package:flutter/material.dart';
import 'package:flutter_devarchitecture/extensions/claim_provider_extentions.dart';
import '../../core/di/core_initializer.dart';
import '../../core/theme/extensions.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/theme/custom_colors.dart';

ListTile buildNavElement(IconData icon, String text, String route,
    {bool isClickable = true}) {
  return ListTile(
    contentPadding: const EdgeInsets.only(left: 36.0, right: 24.0),
    leading: GestureDetector(
        onTap: () => isClickable ? Modular.to.navigate(route) : () {},
        child: Icon(
          icon,
          size: 24,
        )),
    title: Text(text),
    onTap: () => Modular.to.navigate(route),
  );
}

Future<PopupMenuButton> buildNavWithSubMenuItemElement(BuildContext context,
    IconData icon, String text, List<Map<String, dynamic>> options) async {
  // Claim kontrolüne göre filtreleme yapıyoruz
  final filteredOptions = <Map<String, dynamic>>[];

  for (var option in options) {
    if (option.containsKey('guard') && option['guard'] != null) {
      CoreInitializer()
          .coreContainer
          .logger
          .logDebug(option['guard'].toString());
      var isClaimed = await context.claimProvider
          .hasClaim(context, option['guard'].toString());
      CoreInitializer()
          .coreContainer
          .logger
          .logDebug('Claim kontrol ediliyor: ${option['guard']} -> $isClaimed');

      if (isClaimed) {
        filteredOptions.add(option);
      }
    } else {
      filteredOptions.add(option);
    }
  }

  return PopupMenuButton(
    color: CustomColors.white.getColor,
    surfaceTintColor: CustomColors.white.getColor,
    offset: !context.isMobile ? const Offset(200, 0) : const Offset(0, 0),
    itemBuilder: (context) {
      return List.generate(filteredOptions.length, (index) {
        if (filteredOptions[index].containsKey('subMenu') &&
            filteredOptions[index]['subMenu'] != null) {
          return PopupMenuItem(
            value: Text(filteredOptions[index]["name"]),
            child: FutureBuilder<PopupMenuButton>(
              future: buildNavWithSubMenuItemElement(
                context,
                filteredOptions[index]["icon"],
                filteredOptions[index]["name"],
                List<Map<String, dynamic>>.from(
                    filteredOptions[index]['subMenu']),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Loading göstergesi
                }
                if (snapshot.hasError) {
                  return const SizedBox.shrink(); // Hata durumunda boş döner
                }
                return snapshot.data ?? const SizedBox.shrink();
              },
            ),
          );
        } else {
          return PopupMenuItem(
            value: Text(filteredOptions[index]["name"]),
            child: GestureDetector(
              onTap: () => Modular.to.navigate(filteredOptions[index]["route"]),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 8.0, right: 8.0),
                leading: Icon(
                  filteredOptions[index]["icon"],
                  size: 24,
                ),
                title: Text(filteredOptions[index]["name"]),
              ),
            ),
          );
        }
      });
    },
    child: AbsorbPointer(
      child: ListTile(
        trailing: const Icon(
          Icons.chevron_right,
          size: 24,
        ),
        contentPadding: const EdgeInsets.only(left: 36.0, right: 24.0),
        leading: Icon(
          icon,
          size: 24,
        ),
        title: Text(text),
      ),
    ),
  );
}

DrawerHeader buildLogoWidget() {
  return DrawerHeader(
    padding:
        const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 20.0, left: 20.0),
    child: Image.asset(
      'assets/images/logo.png',
    ),
  );
}
