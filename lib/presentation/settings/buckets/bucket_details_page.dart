import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';

class BucketDetailsPage extends StatelessWidget {
  final Bucket bucket;

  const BucketDetailsPage({Key key, this.bucket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translateOf(context, "txt_bucket_details")),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: WidthConstrainedWidget(
          child: BucketDetailsEditWidget(
            bucket: bucket,
          ),
        ),
      ),
    );
  }
}

class BucketDetailsEditWidget extends StatefulWidget {
  final Bucket bucket;

  const BucketDetailsEditWidget({Key key, @required this.bucket})
      : super(key: key);

  @override
  _BucketDetailsEditWidgetState createState() =>
      _BucketDetailsEditWidgetState();
}

class _BucketDetailsEditWidgetState extends State<BucketDetailsEditWidget> {
  bool _delete = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.bucket.name;
    descriptionController.text = widget.bucket.description;
  }

  @override
  void dispose() {
    super.dispose();
    final updatedNameText = nameController.text;
    final updatedDescriptionText = descriptionController.text;

    if (!_delete &&
        (widget.bucket.name != updatedNameText ||
            widget.bucket.description != updatedDescriptionText)) {
      final event = UpdateBucketEvent(
        widget.bucket.id,
        name: updatedNameText,
        description: updatedDescriptionText,
      );

      sl<BucketsBloc>().dispatch(event);
    }
    if (_delete) {
      final event = RemoveBucketEvent(widget.bucket.id);
      sl<BucketsBloc>().dispatch(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: AppLocalizations.translateOf(context, "txt_name"),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: AppLocalizations.translateOf(
                  context, "field_input_description"),
            ),
          ),
          SizedBox(height: 8.0),
          FlatButton(
            onPressed: _onDeletePressed,
            child: Text(
              AppLocalizations.translateOf(context, "btn_delete"),
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  void _onDeletePressed() async {
    final result = await showDialog(
      context: context,
      builder: (context) => DeleteDialog(),
    );

    if (result == true) {
      _delete = true;
      Navigator.pop(context);
    }
  }
}