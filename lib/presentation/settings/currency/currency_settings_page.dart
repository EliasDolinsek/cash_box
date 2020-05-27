import 'package:cash_box/domain/account/enteties/currencies.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:cash_box/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

class CurrencySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.translateOf(context, "txt_select_currency")),
        backgroundColor: Colors.white,
      ),
      body: ScreenTypeLayout(
        mobile: MobileCurrencySettingsPage(),
      ),
    );
  }
}

class MobileCurrencySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurrencySettingsWidget();
  }
}

class CurrencySettingsWidget extends StatefulWidget {
  @override
  _CurrencySettingsWidgetState createState() => _CurrencySettingsWidgetState();
}

class _CurrencySettingsWidgetState extends State<CurrencySettingsWidget> {
  Map displayedCurrencies;

  @override
  void initState() {
    super.initState();
    displayedCurrencies = currencies;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchTextField(
              onChanged: _filterCurrencies,
              onSearch: _filterCurrencies,
            ),
          ),
          SizedBox(height: 16.0),
          CurrenciesListWidget(
            selectedCurrency: "USD",
            currencies: displayedCurrencies,
          )
        ],
      ),
    );
  }

  void _filterCurrencies(String search) {
    setState(() {
      displayedCurrencies = Map<String, Map<String, String>>.from(currencies)
        ..removeWhere(
          (key, value) {
            return !key.contains(search) &&
                !value["name"].contains(search) &&
                !value["symbol"].contains(search);
          },
        );
    });
  }
}

class CurrenciesListWidget extends StatefulWidget {
  final String selectedCurrency;
  final Map<String, Map<String, String>> currencies;

  const CurrenciesListWidget({
    Key key,
    @required this.selectedCurrency,
    @required this.currencies,
  }) : super(key: key);

  @override
  _CurrenciesListWidgetState createState() => _CurrenciesListWidgetState();
}

class _CurrenciesListWidgetState extends State<CurrenciesListWidget> {
  String selectedCurrency;

  @override
  void initState() {
    super.initState();
    selectedCurrency = widget.selectedCurrency;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.currencies.entries.map((e) {
        final flag = e.value["flag"];
        final name = e.value["name"];
        final currency = e.key;

        return CurrencyListItem(
          flag: flag,
          name: name,
          selected: selectedCurrency == currency,
        );
      }).toList(),
    );
  }
}

class CurrencyListItem extends StatelessWidget {
  final String flag;
  final String name;
  final bool selected;

  const CurrencyListItem({Key key, this.flag, this.name, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: _buildCountryFlag(),
        backgroundColor: Colors.transparent,
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: _buildTrailing(context),
    );
  }

  Widget _buildCountryFlag() {
    return Image.asset(
      'icons/flags/png/$flag.png',
      package: 'country_icons',
      width: 30,
      fit: BoxFit.fitHeight,
    );
  }

  Widget _buildTrailing(BuildContext context) {
    if (selected) {
      return Icon(
        Icons.check,
        color: Theme.of(context).primaryColor,
      );
    } else {
      return Container(width: 0, height: 0);
    }
  }
}
