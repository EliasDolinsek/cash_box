import 'package:cash_box/presentation/settings/settings_widget.dart';
import 'package:flutter/material.dart';

final pages = {
  "overviewWidget":Text("OVERVIEW"),
  "searchWidget":Text("SEARCH"),
  "statisticsWidget":Text("STATISTICS"),
  "settingsWidget":SettingsWidget()
};

String selectedPage = "settingsWidget";

Widget get page {
  return pages[selectedPage];
}

set pageByIndex(index) => selectedPage = pages.keys.elementAt(index);

int get indexOfPage {
  return pages.keys.toList().indexOf(selectedPage);
}

Color getColorForNavigationPage(String name, BuildContext context) {
  if (name == selectedPage) {
    return getSelectedColor(context);
  } else {
    return Colors.black;
  }
}

Color getSelectedColor(BuildContext context){
  return Theme.of(context).primaryColorDark;
}