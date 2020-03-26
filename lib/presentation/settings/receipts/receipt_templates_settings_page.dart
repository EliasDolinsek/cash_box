import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/templates_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class ReceiptTemplatesSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final templatesBloc = sl<TemplatesBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.translateOf(context, "txt_receipt_templates"),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addNewTemplate(context),
      ),
      body: StreamBuilder(
        stream: templatesBloc.state,
        builder: (_, AsyncSnapshot<TemplatesState> snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            if (data is TemplatesAvailableState) {
              return TemplatesAvailableSettingsWidget(data.templates);
            } else if (data is TemplatesErrorState) {
              templatesBloc.dispatch(GetTemplatesEvent());
              return Text("ERROR");
            } else {
              templatesBloc.dispatch(GetTemplatesEvent());
              return _buildLoading();
            }
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void _addNewTemplate(BuildContext context) {
    final name = AppLocalizations.translateOf(context, "txt_new_template");
    final template = Template.newTemplate(name: name, fields: []);

    final event = AddTemplateEvent(template);
    sl<TemplatesBloc>().dispatch(event);
  }
}

class TemplatesAvailableSettingsWidget extends StatelessWidget {
  final List<Template> templates;

  const TemplatesAvailableSettingsWidget(this.templates, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (templates.isEmpty) return _buildNoTemplates(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Container(
            constraints: BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 1,
                    child: _buildLoaded(),
                  ),
                ),
              ),
            ),
          );
        } else {
          return SingleChildScrollView(child: _buildLoaded());
        }
      },
    );
  }

  Widget _buildNoTemplates(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.translateOf(context, "txt_no_templates"),
      ),
    );
  }

  Widget _buildLoaded() {
    final reversedTemplates = templates.reversed;
    return Column(
      children: reversedTemplates.map((t) => TemplateListItem(t)).toList(),
    );
  }
}

class TemplateListItem extends StatelessWidget {
  final Template template;

  const TemplateListItem(this.template, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_getTemplateNameText(context)),
      subtitle: Text(_templateFieldsInfoAsString(context)),
      onTap: () {
        Navigator.of(context).pushNamed(
          "/receiptTemplatesSettings/templateDetails",
          arguments: template,
        );
      },
    );
  }

  String _getTemplateNameText(BuildContext context) {
    if (template.name.isEmpty) {
      return AppLocalizations.translateOf(context, "unnamed");
    } else {
      return template.name;
    }
  }

  String _templateFieldsInfoAsString(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (template.fields.isEmpty) {
      return localizations.translate("txt_no_fields");
    } else {
      return template.fields.map((f) {
        return f.description;
      }).join(" · ");
    }
  }
}
