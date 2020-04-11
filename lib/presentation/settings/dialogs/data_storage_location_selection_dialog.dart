import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class DataStorageLocationSelectionDialog extends StatelessWidget {

  final Function onChanged;

  const DataStorageLocationSelectionDialog({Key key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.translateOf(
          context, "data_storage_location_selection_dialog_title")),
      content: FutureBuilder(
        future: _getCurrentDataStorageLocation(),
        builder: (_, data) {
          if (data.hasData) {
            return DataStorageLocationSelectionWidget(_onChanged, data.data);
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text(AppLocalizations.translateOf(context, "dialog_btn_close")),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  void _onChanged(DataStorageLocation location) {
    if(onChanged != null) onChanged();
    sl<Config>().setDataStorageLocation(location);
  }

  Future<DataStorageLocation> _getCurrentDataStorageLocation() {
    return sl<Config>().dataStorageLocation;
  }
}

class DataStorageLocationSelectionWidget extends StatefulWidget {
  final DataStorageLocation currentLocation;
  final Function(DataStorageLocation location) onChanged;

  DataStorageLocationSelectionWidget(this.onChanged, this.currentLocation);

  @override
  _DataStorageLocationSelectionWidgetState createState() =>
      _DataStorageLocationSelectionWidgetState();
}

class _DataStorageLocationSelectionWidgetState
    extends State<DataStorageLocationSelectionWidget> {
  DataStorageLocation _dataStorageLocation;

  @override
  void initState() {
    _dataStorageLocation = widget.currentLocation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RadioListTile(
          value: DataStorageLocation.LOCAL_MOBILE,
          groupValue: _dataStorageLocation,
          onChanged: (value) {
            setState(() => _dataStorageLocation = value);
            widget.onChanged(_dataStorageLocation);
          },
          title: Text(localizations
              .translate("data_storage_location_selection_dialog_local")),
          subtitle: Text(localizations
              .translate("data_storage_location_selection_dialog_local_hint")),
        ),
        RadioListTile(
          value: DataStorageLocation.REMOTE_FIREBASE,
          groupValue: _dataStorageLocation,
          onChanged: (value) {
            setState(() => _dataStorageLocation = value);
            widget.onChanged(_dataStorageLocation);
          },
          title: Text(localizations
              .translate("data_storage_location_selection_dialog_online")),
          subtitle: Text(localizations
              .translate("data_storage_location_selection_dialog_online_hint")),
        )
      ],
    );
  }
}
