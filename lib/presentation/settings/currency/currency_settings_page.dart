import 'package:cash_box/app/accounts_bloc/accounts_bloc.dart';
import 'package:cash_box/app/accounts_bloc/accounts_state.dart';
import 'package:cash_box/app/accounts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/account/enteties/currencies.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        tablet: TabletDesktopCurrencySettingsPage(),
        desktop: TabletDesktopCurrencySettingsPage(),
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

class TabletDesktopCurrencySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: WidthConstrainedWidget(child: CurrencySettingsWidget()),
    );
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
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
            child: SearchTextField(
              onChanged: _filterCurrencies,
              onSearch: _filterCurrencies,
            ),
          ),
          SizedBox(height: 16.0),
          BlocBuilder(
            bloc: sl<AccountsBloc>(),
            builder: (BuildContext context, state) {
              if (state is AccountAvailableState) {
                final account = state.account;
                if (account != null) {
                  return CurrenciesListWidget(
                    selectedCurrency: account.currencyCode,
                    currencies: displayedCurrencies,
                  );
                } else {
                  return LoadingWidget();
                }
              } else {
                return LoadingWidget();
              }
            },
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
            return !key.toLowerCase().contains(search.toLowerCase()) &&
                !value["name"].toLowerCase().contains(search.toLowerCase()) &&
                !value["symbol"].toLowerCase().contains(search.toLowerCase());
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
  void dispose() {
    super.dispose();
    if (selectedCurrency != widget.selectedCurrency) {
      sl<AccountsBloc>()
          .dispatch(UpdateAccountEvent(currencyCode: selectedCurrency));
    }
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
          onTap: () {
            setState(() {
              selectedCurrency = currency;
            });
          },
        );
      }).toList(),
    );
  }
}

class CurrencyListItem extends StatelessWidget {
  final String flag;
  final String name;
  final bool selected;
  final Function onTap;

  const CurrencyListItem(
      {Key key, this.onTap, this.flag, this.name, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
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
