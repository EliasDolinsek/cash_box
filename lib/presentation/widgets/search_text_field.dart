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
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(9),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 4.0, left: 16.0, right: 16.0),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: _appliedHintText(context),
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () => widget.onSearch(_controller.text),
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              //onPressed: () => onSearch(_controller.text) ?? () {},
            ),
          ),
          onChanged: widget.onChanged,
          onSubmitted: widget.onSearch,
        ),
      ),
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
