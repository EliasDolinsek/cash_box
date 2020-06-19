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
      body: ScreenTypeLayout(
          mobile: Align(
        alignment: Alignment.topCenter,
        child: WidthConstrainedWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: _buildContent(context),
          ),
        ),
      )),
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
    return Column(
      children: [
        ComponentActionButton(
          text: AppLocalizations.translateOf(context, "btn_select_none"),
          onPressed: () => Navigator.of(context)
              .pushReplacementNamed("/addReceipt/detailsInput", arguments: []),
        ),
        Builder(
          builder: (context) {
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
          },
        )
      ],
    );
  }

  Widget _buildTemplatesList(BuildContext context, List<Template> templates) {
    return Column(
      children: templates.map((template) {
        return TemplateListTile(
          template: template,
          onTap: () {
            Navigator.of(context).pushReplacementNamed(
              "/addReceipt/detailsInput",
              arguments: template.fields.map((e) => e.cloneWithNewId()).toList(),
            );
          },
        );
      }).toList(),
    );
  }
}
