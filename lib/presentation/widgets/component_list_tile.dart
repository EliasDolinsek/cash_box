import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class ComponentListTile extends StatelessWidget {
  final String title;
  final String description;
  final Function onTap;
  final Color avatarBorderColor;

  ComponentListTile(
      {@required this.title,
      this.description,
      this.onTap,
      this.avatarBorderColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: avatarBorderColor ?? Theme.of(context).primaryColor,
        child: CircleAvatar(
          child: Builder(
            builder: (context) {
              final secureTitle = _getTitle(context);
              return Text(
                secureTitle.length >= 2
                    ? secureTitle.substring(0, 2)
                    : secureTitle,
              );
            },
          ),
          radius: 21,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      title: Text(_getTitle(context)),
      subtitle: description != null ? Text(_getDescription(context)) : null,
    );
  }

  String _getTitle(BuildContext context) {
    if (title == null || title.isEmpty) {
      return AppLocalizations.translateOf(context, "unnamed");
    } else {
      return title;
    }
  }

  String _getDescription(BuildContext context) {
    if (description == null || description.isEmpty) {
      return AppLocalizations.translateOf(context, "txt_no_description");
    } else {
      return description;
    }
  }
}

class TitleOnlyComponentListTile extends StatelessWidget {
  final String title;
  final Function onTap;
  final Color avatarBorderColor;

  const TitleOnlyComponentListTile(
      {Key key, this.title, this.onTap, this.avatarBorderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ComponentListTile(
        onTap: onTap,
        title: title,
        avatarBorderColor: avatarBorderColor,
      ),
    );
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

class TemplateListTile extends StatelessWidget {
  final Template template;
  final Function onTap;

  const TemplateListTile({Key key, this.template, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleOnlyComponentListTile(
      onTap: onTap,
      title: template.name,
    );
  }
}

class TagListTile extends StatelessWidget {
  final Tag tag;
  final Function onTap;

  const TagListTile({Key key, this.tag, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleOnlyComponentListTile(
      title: tag.name,
      onTap: onTap,
      avatarBorderColor: tag.colorAsColor,
    );
  }
}

class ContactListItem extends StatelessWidget {
  final Contact contact;
  final Function onTap;

  const ContactListItem(this.contact, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentListTile(
      title: contact.name,
      description: _contactFieldsInfoAsString(context),
      onTap: onTap,
    );
  }

  String _contactFieldsInfoAsString(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (contact.fields.isEmpty) {
      return localizations.translate("txt_no_fields");
    } else {
      return contact.fields.map((f) {
        if (f.description.trim().isEmpty) {
          return AppLocalizations.translateOf(context, "unnamed");
        } else {
          return f.description;
        }
      }).join(" · ");
    }
  }
}
