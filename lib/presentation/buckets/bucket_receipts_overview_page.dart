import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/search/receipts_overview_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BucketReceiptsOverviewPage extends StatelessWidget {
  final Bucket bucket;

  const BucketReceiptsOverviewPage({Key key, @required this.bucket})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bucket.name),
      ),
      body: WidthConstrainedWidget(
        child: BlocBuilder(
          bloc: sl<ReceiptsBloc>(),
          builder: (context, state) {
            if (state is ReceiptsAvailableState) {
              if (state.receipts != null) {
                final receipts = state.receipts
                    .where((element) => bucket.receiptsIDs.contains(element.id))
                    .toList();

                if (receipts.isNotEmpty) {
                  return ReceiptsOverviewWidget(
                    receipts: receipts,
                    onTap: (receipt) => Navigator.of(context).pushNamed(
                      "/editReceipt",
                      arguments: receipt.id,
                    ),
                  );
                } else {
                  return _buildNoReceipts(context);
                }
              } else {
                return Center(child: LoadingWidget());
              }
            } else {
              return Center(child: LoadingWidget());
            }
          },
        ),
      ),
    );
  }

  Widget _buildNoReceipts(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.translateOf(context, "txt_no_receipts")),
    );
  }
}
