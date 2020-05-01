import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/fields/field_card_widget.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TagDetailsPage extends StatefulWidget {
  final Tag tag;

  const TagDetailsPage(this.tag, {Key key}) : super(key: key);

  @override
  _TagDetailsPageState createState() => _TagDetailsPageState();
}

class _TagDetailsPageState extends State<TagDetailsPage> {
  bool _delete = false;
  String _name;
  Color _color;

  @override
  void initState() {
    super.initState();
    _name = widget.tag.name;
    _color = widget.tag.colorAsColor;
  }

  @override
  void dispose() {
    super.dispose();

    if (!_delete) {
      final event = UpdateTagEvent(
        widget.tag.id,
        name: _name,
        color: Tag.colorAsString(_color),
      );
      sl<TagsBloc>().dispatch(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: Colors.white,
        actions: <Widget>[
          _buildDeleteButton(),
        ],
      ),
      body: Center(
        child: ResponsiveWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: <Widget>[
                _buildNameFieldCard(),
                _buildColorCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getAppBarTitle() {
    if (widget.tag.name.isEmpty) {
      return AppLocalizations.translateOf(context, "unnamed");
    } else {
      return widget.tag.name;
    }
  }

  Widget _buildNameFieldCard() {
    final field = Field.newField(
      type: FieldType.text,
      description: "Name",
      value: _name,
      storageOnly: true
    );

    return FieldWidget(
      field,
      deletable: false,
      descriptionEditable: false,
      typeEditable: false,
      onFieldChanged: (update) {
        _name = update.value;
      },
    );
  }

  Widget _buildColorCard() {
    final localizations = AppLocalizations.of(context);
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _color,
          ),
          title: Text(localizations.translate("txt_color")),
          trailing: MaterialButton(
            child: Text(localizations.translate("btn_change")),
            onPressed: _showPickColorDialog,
          ),
        ),
      ),
    );
  }

  void _showPickColorDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title:
              Text(AppLocalizations.translateOf(context, "txt_select_color")),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _color,
              onColorChanged: (result) {
                setState(() {
                  _color = result;
                });
              },
            ),
          ),
          actions: <Widget>[
            _buildOkButton(),
          ],
        );
      },
    );
  }

  Widget _buildOkButton() {
    return MaterialButton(
      child: Text(AppLocalizations.translateOf(context, "btn_ok")),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget _buildDeleteButton() {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: _checkAndDelete,
    );
  }

  void _checkAndDelete() async {
    final result =
        await showDialog(context: context, builder: (_) => DeleteDialog());
    if (result != null && result) {
      _deleteTag(context);
    }
  }

  void _deleteTag(BuildContext context) {
    _delete = true;
    final event = RemoveTagEvent(widget.tag.id);

    sl<TagsBloc>().dispatch(event);
    Navigator.of(context).pop();
  }
}
