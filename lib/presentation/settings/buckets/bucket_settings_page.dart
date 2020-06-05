import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/component_action_button.dart';
import 'package:cash_box/presentation/widgets/component_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BucketsSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translateOf(context, "txt_buckets")),
      ),
      body: ScreenTypeLayout(
        mobile: Align(
          alignment: Alignment.topCenter,
          child: WidthConstrainedWidget(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: _BucketSettingsPageContentWidget(),
            ),
          ),
        )
      ),
    );
  }
}

class _BucketSettingsPageContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ComponentActionButton(
            text: AppLocalizations.translateOf(context, "btn_add_bucket"),
            onPressed: () => _addNewBucket(context),
          ),
          BlocBuilder(
            bloc: sl<BucketsBloc>(),
            builder: (context, state) {
              if (state is BucketsAvailableState) {
                if (state.buckets != null) {
                  return _buildBucketsList(context, state.buckets);
                } else {
                  return LoadingWidget();
                }
              } else {
                return LoadingWidget();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildBucketsList(BuildContext context, List<Bucket> buckets) {
    return Column(
      children: buckets
          .map(
            (e) => BucketListTile(
              bucket: e,
              onTap: () => Navigator.of(context)
                  .pushNamed("/bucketSettings/bucketDetails", arguments: e),
            ),
          )
          .toList(),
    );
  }

  void _addNewBucket(BuildContext context) {
    Bucket bucket = Bucket.newBucket(
      name: "",
      description: "",
      receiptsIDs: [],
    );

    sl<BucketsBloc>().dispatch(AddBucketEvent(bucket));
    Navigator.of(context)
        .pushNamed("/bucketSettings/bucketDetails", arguments: bucket);
  }
}