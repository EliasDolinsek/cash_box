import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final String title;
  final String initialValue;
  final Function(String value) onChanged;

  const TextInputWidget(
      {Key key, this.title, this.initialValue, this.onChanged})
      : super(key: key);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialValue ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder()
          ),
        )
      ],
    );
  }
}
