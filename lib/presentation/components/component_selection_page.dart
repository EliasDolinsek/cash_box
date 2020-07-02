import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:flutter/material.dart';

class ComponentSelectionPage extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Function onNoneSelected;
  final Widget content;

  const ComponentSelectionPage(
      {Key key,
      @required this.title,
      @required this.actions,
      @required this.onNoneSelected,
      @required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: SpacedScreenTypeLayout(
        mobile: Align(
          alignment: Alignment.topCenter,
          child: WidthConstrainedWidget(
            child: Column(
              children: <Widget>[
                _buildNoneSelection(context),
                Expanded(child: content)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoneSelection(BuildContext context){
    if(onNoneSelected != null){
      return Column(
        children: <Widget>[
          SizedBox(height: 8.0),
          MaterialButton(
            child: Text(AppLocalizations.translateOf(context, "btn_select_none")),
            onPressed: onNoneSelected,
          ),
          SizedBox(height: 16.0),
        ],
      );
    } else {
      return Container();
    }
  }
}
