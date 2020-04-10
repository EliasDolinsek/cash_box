import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/templates_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/template_list_item.dart';
import 'package:flutter/material.dart';

class AddReceiptTemplateSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.translateOf(context, "txt_select_template"),
        ),
        actions: <Widget>[
          _buildEditTemplatesButton(context),
        ],
        backgroundColor: Colors.white,
      ),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final templatesBloc = sl<TemplatesBloc>();
    return StreamBuilder(
      stream: templatesBloc.state,
      builder: (_, AsyncSnapshot<TemplatesState> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is TemplatesAvailableState) {
            final templates = data.templates;
            return _buildLoaded(context, templates);
          } else if (data is TemplatesErrorState) {
            templatesBloc.dispatch(GetTemplatesEvent());
            return ErrorWidget(data.errorMessage);
          } else {
            templatesBloc.dispatch(GetTemplatesEvent());
            return LoadingWidget();
          }
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.of(context)
          .pushNamed("/addReceipt/detailsInput", arguments: []),
      label: Text(
        AppLocalizations.translateOf(context, "btn_skip"),
      ),
    );
  }

  Widget _buildEditTemplatesButton(BuildContext context) {
    return MaterialButton(
      child: Text(AppLocalizations.translateOf(context, "btn_edit_templates")),
      onPressed: () =>
          Navigator.of(context).pushNamed("/receiptTemplatesSettings"),
    );
  }

  Widget _buildLoaded(BuildContext context, List<Template> templates) {
    if (templates.isNotEmpty) {
      return SingleChildScrollView(child: _buildTemplatesList(context, templates));
    } else {
      return Center(
        child: Text(
          AppLocalizations.translateOf(context, "txt_no_templates"),
        ),
      );
    }
  }

  Widget _buildTemplatesList(BuildContext context, List<Template> templates) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: templates.map((template) {
        return TemplateListItem(
          template,
          onTap: () {
            Navigator.of(context).pushReplacementNamed("/addReceipt/detailsInput",
                arguments: template.fields);
          },
        );
      }).toList(),
    );
  }

}
