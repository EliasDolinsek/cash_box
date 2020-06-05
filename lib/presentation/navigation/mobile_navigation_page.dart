import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/widgets/receipt_month_selection_widget.dart';
import 'navigation_config.dart' as config;
import 'package:flutter/material.dart';

class MobileNavigationPage extends StatefulWidget {
  @override
  _MobileNavigationPageState createState() => _MobileNavigationPageState();
}

class _MobileNavigationPageState extends State<MobileNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CashBox"),
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: <Widget>[
          ReceiptMonthSelectionWidget(),
        ],
      ),
      body: config.page,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/addReceipt"),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: config.indexOfPage,
        selectedItemColor: config.getSelectedColor(context),
        unselectedItemColor: Colors.black,
        onTap: _onTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              AppLocalizations.translateOf(context, "navigation_overview"),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              AppLocalizations.translateOf(context, "navigation_search"),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text(
              AppLocalizations.translateOf(context, "navigation_statistics"),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text(
              AppLocalizations.translateOf(context, "navigation_settings"),
            ),
          )
        ],
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      config.pageByIndex = index;
    });
  }
}
