import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final Function(String text) onChanged;
  final Function(String text) onSearch;

  const SearchTextField({Key key, this.hintText, this.onChanged, this.onSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _controller = TextEditingController();
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(9),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 4.0, left: 16.0, right: 16.0),
        child: TextField(
          //controller: _controller,
          decoration: InputDecoration(
            hintText: _appliedHintText(context),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              //onPressed: () => onSearch(_controller.text) ?? () {},
            ),
          ),
          onChanged: onChanged,
          onSubmitted: onSearch,
        ),
      ),
    );
  }

  String _appliedHintText(BuildContext context) {
    if (hintText != null) {
      return hintText;
    } else {
      return AppLocalizations.translateOf(context, "txt_search");
    }
  }
}
