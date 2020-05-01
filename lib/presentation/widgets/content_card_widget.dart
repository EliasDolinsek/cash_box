import 'package:cash_box/presentation/widgets/default_card.dart';
import 'package:flutter/material.dart';

class ContentCardWidget extends StatelessWidget {
  final Widget content;

  const ContentCardWidget({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultCard(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }
}

class ListContentWidget extends StatelessWidget {
  final List<Widget> items;

  const ListContentWidget({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items,
      crossAxisAlignment: CrossAxisAlignment.start,
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
      content: ListContentWidget(items: items),
    );
  }
}

class TitledContentWidget extends StatelessWidget {
  final Widget title, content;

  const TitledContentWidget({Key key, this.title, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListContentWidget(
      items: [title, SizedBox(height: 8.0), content],
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
    return ContentCardWidget(
      content: TitledContentWidget(
        title: title,
        content: content,
      ),
    );
  }
}

class TitledListContentWidget extends StatelessWidget {
  final Widget title;
  final List<Widget> items;

  const TitledListContentWidget(
      {Key key, @required this.title, @required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListContentWidget(
      items: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: title,
        )
      ]..addAll(items),
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
    return ContentCardWidget(
      content: TitledListContentWidget(title: title, items: items),
    );
  }
}
