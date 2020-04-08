import 'package:flutter/material.dart';

class ContentCardWidget extends StatelessWidget {
  final Widget content;

  const ContentCardWidget({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }
}

class ListContentCardWidget extends StatelessWidget {
  final List<Widget> items;

  const ListContentCardWidget({Key key, @required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentCardWidget(
      content: Column(
        children: items,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

class TitledContentCardWidget extends StatelessWidget {
  final Widget title, content;

  const TitledContentCardWidget(
      {Key key, @required this.title, @required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListContentCardWidget(
      items: [title, SizedBox(height: 8.0), content],
    );
  }
}

class TitledListContentCardWidget extends StatelessWidget {
  final Widget title;
  final List<Widget> items;

  const TitledListContentCardWidget(
      {Key key, @required this.title, @required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListContentCardWidget(items: [title]..addAll(items));
  }
}
