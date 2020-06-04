import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class ComponentListTile extends StatelessWidget {
  final String title;
  final String description;
  final Function onTap;

  ComponentListTile({@required this.title, @required this.description, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 22,
        child: CircleAvatar(
          child: Builder(
            builder: (context) {
              final secureTitle = _getTitle(context);
              return Text(secureTitle.length >= 2 ? secureTitle.substring(0, 2) : secureTitle);
            },
          ),
          radius: 21,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      title: Text(_getTitle(context)),
      subtitle: Text(_getDescription(context)),
    );
  }

  String _getTitle(BuildContext context){
    if(title == null || title.isEmpty){
      return AppLocalizations.translateOf(context, "unnamed");
    } else {
      return title;
    }
  }

  String _getDescription(BuildContext context) {
    if(description == null || description.isEmpty){
      return AppLocalizations.translateOf(context, "txt_no_description");
    } else {
      return description;
    }
  }
}

class BucketListTile extends StatelessWidget {
  final Bucket bucket;
  final Function onTap;

  const BucketListTile({Key key, @required this.bucket, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentListTile(
      onTap: onTap,
      title: bucket.name,
      description: bucket.description,
    );
  }
}
