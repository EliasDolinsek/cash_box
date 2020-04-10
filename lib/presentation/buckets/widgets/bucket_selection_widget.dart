import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/static_widgets/error_text_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_text_widget.dart';
import 'package:flutter/material.dart';

class BucketSelectionWidget extends StatefulWidget {
  final String receiptId;
  final Function(String selectedBucketId) onUpdated;

  const BucketSelectionWidget(
      {Key key, @required this.receiptId, this.onUpdated})
      : super(key: key);

  @override
  _BucketSelectionWidgetState createState() => _BucketSelectionWidgetState();
}

class _BucketSelectionWidgetState extends State<BucketSelectionWidget> {

  Bucket selectedBucket;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sl<BucketsBloc>().state,
      builder: (_, AsyncSnapshot<BucketsState> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is BucketsAvailableState) {
            return _buildLoaded(context, data.buckets);
          } else if (data is BucketsErrorState) {
            loadBuckets();
            return ErrorTextWidget(
              text: AppLocalizations.translateOf(
                context,
                "txt_could_not_load_bucket",
              ),
            );
          } else {
            loadBuckets();
            return LoadingTextWidget();
          }
        } else {
          return LoadingTextWidget();
        }
      },
    );
  }

  void loadBuckets() {
    sl<BucketsBloc>().dispatch(GetBucketsEvent());
  }

  Widget _buildLoaded(BuildContext context, List<Bucket> buckets) {
    final bucket = buckets.firstWhere(
        (element) => element.receiptsIDs.contains(widget.receiptId),
        orElse: () => null);

    selectedBucket = bucket;
    return _buildBucketSelectionButton(context);
  }

  Widget _buildBucketSelectionButton(BuildContext context) {
    return MaterialButton(
      child: Builder(
        builder: (context) {
          if (selectedBucket != null) {
            return Text(selectedBucket.name);
          } else {
            return Text(
                AppLocalizations.translateOf(context, "btn_select_bucket"));
          }
        },
      ),
      onPressed: () => Navigator.of(context).pushNamed(
        "/bucketSelection",
        arguments: {
          "initialSelectedBucketId": selectedBucket?.id,
          "onChanged": (newBucket) {
            _updateBucket(newBucket);
            setState(() => selectedBucket = newBucket);
          }
        },
      ),
    );
  }

  void _updateBucket(Bucket newBucket){
    if(newBucket != null){
      if(selectedBucket != null){
        sl<BucketsBloc>().dispatch(RemoveReceiptFromBucketEvent(selectedBucket.id, widget.receiptId));
      }
      sl<BucketsBloc>().dispatch(AddReceiptToBucketEvent(newBucket.id, widget.receiptId));
    } else {
      sl<BucketsBloc>().dispatch(RemoveReceiptFromBucketEvent(selectedBucket.id, widget.receiptId));
    }
  }
}
