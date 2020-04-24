import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class BucketListItem extends StatelessWidget {
  final Function onTap;
  final Bucket bucket;

  const BucketListItem(this.bucket, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(_getTitle(context)),
      subtitle: Text(_getSubtitle(context)),
      leading: CircleAvatar(
        child: Text(
          _getLeadingText(),
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  String _getTitle(BuildContext context) {
    if (bucket.name == null || bucket.name.isEmpty) {
      return AppLocalizations.translateOf(context, "unnamed");
    } else {
      return bucket.name;
    }
  }

  String _getSubtitle(BuildContext context) {
    if (bucket.description == null || bucket.description.isEmpty) {
      return AppLocalizations.translateOf(context, "txt_no_description");
    } else {
      return bucket.name;
    }
  }

  String _getLeadingText() {
    if (bucket.name == null || bucket.name.isEmpty) {
      return "?";
    } else {
      return bucket.name.substring(0, 2);
    }
  }
}
