import 'package:cash_box/presentation/buckets/buckets_overview_widget.dart';
import 'package:cash_box/presentation/search/search_widget.dart';
import 'package:cash_box/presentation/settings/settings_overview_widget.dart';
import 'package:cash_box/presentation/overview/overview_widget.dart';
import 'package:cash_box/presentation/statistics/statistics_widget.dart';
import 'package:flutter/material.dart';

final pages = {
  "overviewWidget": OverviewWidget(),
  "searchWidget": SearchWidget(),
  "statisticsWidget": StatisticsWidget(),
  "settingsWidget": SettingsOverviewWidget()
};

String selectedPage = "overviewWidget";

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

Color getSelectedColor(BuildContext context) {
  return Theme.of(context).primaryColorDark;
}
