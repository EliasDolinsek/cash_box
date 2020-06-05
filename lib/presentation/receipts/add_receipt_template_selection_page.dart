import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/templates_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/component_list_tile.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Center(child: ResponsiveCardWidget(child: _buildContent(context))),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder(
      bloc: sl<TemplatesBloc>(),
      builder: (context, state) {
        if (state is TemplatesAvailableState) {
          if (state.templates != null) {
            return _buildLoaded(context, state.templates);
          } else {
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
      return _buildTemplatesList(context, templates);
    } else {
      return Center(
        child: Text(
          AppLocalizations.translateOf(context, "txt_no_templates"),
        ),
      );
    }
  }

  Widget _buildTemplatesList(BuildContext context, List<Template> templates) {
    return ListView(
      children: templates.map((template) {
        return TemplateListTile(
          template: template,
          onTap: () {
            Navigator.of(context).pushReplacementNamed(
                "/addReceipt/detailsInput",
                arguments: template.fields);
          },
        );
      }).toList(),
    );
  }
}
