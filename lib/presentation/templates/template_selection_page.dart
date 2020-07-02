import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/templates_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/components/component_selection_page.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/component_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemplateSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentSelectionPage(
      title: AppLocalizations.translateOf(context, "txt_select_template"),
      actions: [
        _buildEditTemplatesButton(context),
      ],
      onNoneSelected: () => Navigator.of(context).pop(<Field>[]),
      content: _buildContent(context),
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

  Widget _buildEditTemplatesButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () =>
          Navigator.of(context).pushNamed("/receiptTemplatesSettings"),
    );
  }

  Widget _buildLoaded(BuildContext context, List<Template> templates) {
    if (templates.isNotEmpty) {
      return SingleChildScrollView(
          child: _buildTemplatesList(context, templates));
    } else {
      return Expanded(
        child: Center(
          child: Text(
            AppLocalizations.translateOf(context, "txt_no_templates"),
          ),
        ),
      );
    }
  }

  Widget _buildTemplatesList(BuildContext context, List<Template> templates) {
    return Column(
      children: templates.map((template) {
        return TemplateListTile(
          template: template,
          onTap: () => Navigator.of(context).pop(template.fields),
        );
      }).toList(),
    );
  }
}
