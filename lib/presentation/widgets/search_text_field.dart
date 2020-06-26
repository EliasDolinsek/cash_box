import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final String hintText;
  final Function(String text) onChanged;
  final Function(String text) onSearch;

  const SearchTextField({Key key, this.hintText, this.onChanged, this.onSearch})
      : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: _appliedHintText(context),
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () => widget.onSearch(_controller.text),
          icon: Icon(
            Icons.search,
          ),
          //onPressed: () => onSearch(_controller.text) ?? () {},
        ),
      ),
      onChanged: widget.onChanged,
      onSubmitted: widget.onSearch,
    );
  }

  String _appliedHintText(BuildContext context) {
    if (widget.hintText != null) {
      return widget.hintText;
    } else {
      return AppLocalizations.translateOf(context, "txt_search");
    }
  }
}
