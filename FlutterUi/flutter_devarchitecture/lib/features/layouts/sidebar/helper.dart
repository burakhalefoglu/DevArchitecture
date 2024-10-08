import 'package:flutter/material.dart';
import '../../../core/theme/extensions.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/theme/custom_colors.dart';

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

PopupMenuButton buildNavWithSubMenuItemElement(BuildContext context,
    IconData icon, String text, List<Map<String, dynamic>> options) {
  return PopupMenuButton(
    color: CustomColors.white.getColor,
    surfaceTintColor: CustomColors.white.getColor,
    offset: !context.isMobile ? const Offset(200, 0) : const Offset(0, 0),
    itemBuilder: (context) {
      return List.generate(options.length, (index) {
        // Eğer alt menü varsa, aynı fonksiyon tekrar çağrılır.
        if (options[index].containsKey('subMenu') &&
            options[index]['subMenu'] != null) {
          return PopupMenuItem(
            value: Text(options[index]["name"]),
            child: buildNavWithSubMenuItemElement(
              context,
              options[index]["icon"],
              options[index]["name"],
              List<Map<String, dynamic>>.from(options[index]['subMenu']),
            ),
          );
        } else {
          // Eğer alt menü yoksa, basit bir ListTile oluşturulur.
          return PopupMenuItem(
            value: Text(options[index]["name"]),
            child: GestureDetector(
              onTap: () => Modular.to.navigate(options[index]["route"]),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 8.0, right: 8.0),
                leading: Icon(
                  options[index]["icon"],
                  size: 24,
                ),
                title: Text(options[index]["name"]),
              ),
            ),
          );
        }
      });
    },
    child: AbsorbPointer(
      child: ListTile(
        trailing: Icon(
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
