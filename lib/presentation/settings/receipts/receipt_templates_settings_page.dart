import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/templates_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/component_action_button.dart';
import 'package:cash_box/presentation/widgets/component_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiptTemplatesSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.translateOf(context, "txt_receipt_templates"),
        ),
        backgroundColor: Colors.white,
      ),
      body: ScreenTypeLayout(
          mobile: Align(
        alignment: Alignment.topCenter,
        child: WidthConstrainedWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: _TemplatesSettingsPageContentWidget(),
          ),
        ),
      )),
    );
  }
}

class _TemplatesSettingsPageContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ComponentActionButton(
            text: AppLocalizations.translateOf(context, "btn_add_template"),
            onPressed: () => _addNewTemplate(context),
          ),
          BlocBuilder(
            bloc: sl<TemplatesBloc>(),
            builder: (context, state) {
              if (state is TemplatesAvailableState) {
                if (state.templates != null) {
                  return _buildTemplatesList(context, state.templates);
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

  Widget _buildTemplatesList(BuildContext context, List<Template> templates) {
    return Column(
      children: templates
          .map(
            (t) => TemplateListTile(
              template: t,
              onTap: () {
                Navigator.of(context).pushNamed(
                  "/receiptTemplatesSettings/templateDetails",
                  arguments: t,
                );
              },
            ),
          )
          .toList(),
    );
  }

  _addNewTemplate(BuildContext context) {
    final template = Template.newTemplate(name: "", fields: []);

    final event = AddTemplateEvent(template);
    sl<TemplatesBloc>().dispatch(event);

    Navigator.of(context).pushNamed(
      "/receiptTemplatesSettings/templateDetails",
      arguments: template,
    );
  }
}
