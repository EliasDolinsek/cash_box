import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

class BucketSelectionPage extends StatelessWidget {
  final Function(Bucket bucket) onChanged;
  final String initialSelectedBucketId;

  const BucketSelectionPage(
      {Key key, this.initialSelectedBucketId, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.translateOf(context, "txt_bucket_selection"),
        ),
        actions: <Widget>[_buildSelectNoBucketButton(context)],
      ),
      body: StreamBuilder(
        stream: sl<BucketsBloc>().state,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data is BucketsAvailableState) {
              return _BucketSelectionWidget(
                buckets: data.buckets,
                initialSelectedBucketId: initialSelectedBucketId,
                onChanged: onChanged,
              );
            } else if (data is BucketsErrorState) {
              _loadBuckets();
              return ErrorWidget(data.errorMessage);
            } else {
              _loadBuckets();
              return LoadingWidget();
            }
          } else {
            return LoadingWidget();
          }
        },
      ),
    );
  }

  void _loadBuckets() {
    sl<BucketsBloc>().dispatch(GetBucketsEvent());
  }

  Widget _buildSelectNoBucketButton(BuildContext context) {
    return MaterialButton(
      child: Text(AppLocalizations.translateOf(context, "btn_select_none")),
      onPressed: () {
        onChanged(null);
        Navigator.pop(context);
      },
    );
  }
}

class _BucketSelectionWidget extends StatefulWidget {
  final Function(Bucket bucket) onChanged;
  final List<Bucket> buckets;
  final String initialSelectedBucketId;

  const _BucketSelectionWidget(
      {Key key,
      @required this.buckets,
      this.initialSelectedBucketId,
      this.onChanged})
      : super(key: key);

  @override
  _BucketSelectionWidgetState createState() => _BucketSelectionWidgetState();
}

class _BucketSelectionWidgetState extends State<_BucketSelectionWidget> {
  String _selectedBucketId;

  @override
  void initState() {
    super.initState();
    _selectedBucketId = widget.initialSelectedBucketId;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.buckets.isNotEmpty) {
      return _buildContent();
    } else {
      return Center(
        child: Text(
          AppLocalizations.translateOf(context, "txt_no_buckets"),
        ),
      );
    }
  }

  Widget _buildContent() {
    return ResponsiveWidget(
      child: ListView.separated(
        itemBuilder: (_, index) {
          final bucket = widget.buckets[index];
          return RadioListTile(
            title: Text(bucket.name),
            subtitle: Text(bucket.description),
            value: bucket.id,
            groupValue: _selectedBucketId,
            onChanged: (value) {
              setState(() => _selectedBucketId = value);
              widget.onChanged(bucket);
            },
          );
        },
        separatorBuilder: (_, __) => Divider(),
        itemCount: widget.buckets.length,
      ),
    );
  }
}