import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/components/component_selection_page.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/component_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BucketSelectionPage extends StatelessWidget {
  final Function(Bucket bucket) onChanged;
  final String initialSelectedBucketId;

  const BucketSelectionPage(
      {Key key, this.initialSelectedBucketId, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentSelectionPage(
      title: AppLocalizations.translateOf(context, "txt_bucket_selection"),
      actions: [_buildEditBucketsAction(context)],
      onNoneSelected: () {
        onChanged(null);
        Navigator.pop(context);
      },
      content: BlocBuilder(
        bloc: sl<BucketsBloc>(),
        builder: (context, state) {
          if (state is BucketsAvailableState) {
            if (state.buckets != null) {
              return _buildContent(context, state.buckets);
            } else {
              return _buildError(context);
            }
          } else {
            return LoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.translateOf(
          context,
          "txt_default_error_message",
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Bucket> buckets) {
    return _BucketSelectionWidget(
      buckets: buckets,
      initialSelectedBucketId: initialSelectedBucketId,
      onChanged: onChanged,
    );
  }

  Widget _buildEditBucketsAction(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => Navigator.of(context).pushNamed("/bucketSettings"),
    );
  }
}

class _BucketSelectionWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (buckets.isNotEmpty) {
      return _buildContent(context);
    } else {
      return Center(
        child: Text(
          AppLocalizations.translateOf(context, "txt_no_buckets"),
        ),
      );
    }
  }

  Widget _buildContent(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        final bucket = buckets[index];
        return InkWell(
          onTap: () => onBucketSelected(context, bucket),
          child: Row(
            children: <Widget>[
              Flexible(
                child: BucketListTile(
                  bucket: bucket,
                ),
              ),
              Radio(
                value: bucket.id,
                groupValue: initialSelectedBucketId,
                onChanged: (_) => onBucketSelected(context, bucket),
              ),
              SizedBox(width: 8)
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => Divider(),
      itemCount: buckets.length,
    );
  }

  void onBucketSelected(BuildContext context, bucket) {
    onChanged(bucket);
    Navigator.pop(context);
  }
}
