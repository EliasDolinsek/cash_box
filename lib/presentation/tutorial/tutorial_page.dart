import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  final String name;

  const TutorialPage({Key key, this.name = ""}) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final pages = _getPages();
    return Scaffold(
      body: PageView(
        children: pages,
        controller: pageController,
      ),
    );
  }

  List<Widget> _getPages() => <Widget>[
        _HiWidget(name: widget.name),
        _ReceiptsTutorialWidget(),
        _TemplatesTutorialWidget(),
        _TagsTutorialWidget(),
        _BucketsTutorialWidget(),
        _TutorialFinishedWidget()
      ];
}

class _HiWidget extends StatelessWidget {
  final String name;

  const _HiWidget({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: WidthConstrainedWidget(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.translateOf(context, "txt_tutorial_hi")
                            .replaceAll("%{name}", name),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 48,
                        ),
                      ),
                      SizedBox(height: 42.0),
                      Text(
                        AppLocalizations.translateOf(
                            context, "txt_tutorial_description"),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 42.0),
                    child: Text(AppLocalizations.translateOf(
                        context, "txt_swipe_right")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReceiptsTutorialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: WidthConstrainedWidget(
        child: _ComponentTutorialMobilePortrait(
          icon: Icons.description,
          title: AppLocalizations.translateOf(context, "txt_receipts"),
          description: AppLocalizations.translateOf(
              context, "txt_receipts_tutorial_description"),
        ),
      ),
    );
  }
}

class _TemplatesTutorialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: WidthConstrainedWidget(
        child: _ComponentTutorialMobilePortrait(
          icon: Icons.move_to_inbox,
          title: AppLocalizations.translateOf(context, "txt_templates"),
          description: AppLocalizations.translateOf(
              context, "txt_templates_tutorial_description"),
        ),
      ),
    );
  }
}

class _TagsTutorialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: WidthConstrainedWidget(
        child: _ComponentTutorialMobilePortrait(
          icon: Icons.bookmark,
          title: AppLocalizations.translateOf(context, "txt_tags"),
          description: AppLocalizations.translateOf(
              context, "txt_tags_tutorial_description"),
        ),
      ),
    );
  }
}

class _BucketsTutorialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: WidthConstrainedWidget(
        child: _ComponentTutorialMobilePortrait(
          icon: Icons.label_outline,
          title: AppLocalizations.translateOf(context, "txt_buckets"),
          description: AppLocalizations.translateOf(
              context, "txt_buckets_tutorial_description"),
        ),
      ),
    );
  }
}

class _TutorialFinishedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 8,
          child: _ComponentTutorialMobilePortrait(
            icon: Icons.done_outline,
            title: AppLocalizations.translateOf(context, "txt_done"),
            description: AppLocalizations.translateOf(
                context, "txt_tutorial_done_description"),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: OutlineButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                  AppLocalizations.translateOf(context, "btn_close_tutorial")),
            ),
          ),
        )
      ],
    );
  }
}

class _ComponentTutorialMobilePortrait extends StatelessWidget {
  final IconData icon;
  final String title, description;

  const _ComponentTutorialMobilePortrait(
      {Key key, this.icon, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: 88,
                ),
                SizedBox(height: 24.0),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 38,
                  ),
                ),
                SizedBox(height: 18.0),
                Text(
                  description,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
            flex: 4,
          )
        ],
      ),
    );
  }
}
