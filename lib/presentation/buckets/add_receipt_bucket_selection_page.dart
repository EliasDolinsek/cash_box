import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/component_action_button.dart';
import 'package:cash_box/presentation/widgets/component_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddReceiptBucketSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BucketSelectionPage(
      onBucketSelected: (bucketId) {
        final receipt = Receipt.newReceipt(
          type: ReceiptType.outcome,
          creationDate: DateTime.now(),
          fields: [],
          tagIDs: [],
        );

        sl<ReceiptsBloc>().dispatch(AddReceiptEvent(receipt));
        if (bucketId != null) {
          sl<BucketsBloc>()
              .dispatch(AddReceiptToBucketEvent(bucketId, receipt.id));
        }

        Navigator.of(context).pushReplacementNamed(
          "/addReceipt/detailsInput",
          arguments: receipt,
        );
      },
    );
  }
}

class _BucketSelectionPage extends StatelessWidget {
  final Function(String bucketId) onBucketSelected;

  const _BucketSelectionPage({Key key, this.onBucketSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.translateOf(context, "txt_bucket_selection")),
      ),
      body: SpacedScreenTypeLayout(
        mobile: Align(
          alignment: Alignment.topCenter,
          child: WidthConstrainedWidget(
            child: Column(
              children: [
                SizedBox(height: 8.0),
                ComponentActionButton(
                  text: AppLocalizations.translateOf(context, "btn_select_none"),
                  onPressed: () => onBucketSelected(null),
                ),
                BlocBuilder(
                  bloc: sl<BucketsBloc>(),
                  builder: (context, state) {
                    if (state is BucketsAvailableState) {
                      if (state.buckets != null) {
                        return _buildContent(state.buckets);
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
          ),
        ),
      ),
    );
  }

  Widget _buildContent(List<Bucket> buckets) {
    return Builder(
      builder: (context) {
        if (buckets.isNotEmpty) {
          return SingleChildScrollView(
            child: _buildBucketsList(buckets),
          );
        } else {
          return Expanded(
            child: Center(
              child: Text(
                AppLocalizations.translateOf(context, "txt_no_buckets"),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildBucketsList(List<Bucket> buckets) {
    return Column(
      children: buckets
          .map((e) => BucketListTile(
                bucket: e,
                onTap: () => onBucketSelected(e.id),
              ))
          .toList(),
    );
  }
}
