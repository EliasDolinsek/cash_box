import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_incomes_outcomes_use_case.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/statistics/statistics_list_tile/statistics_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BucketStatisticsWidget extends StatelessWidget {
  final List<Receipt> receipts;

  const BucketStatisticsWidget({Key key, @required this.receipts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl<BucketsBloc>(),
      builder: (context, state) {
        if (state is BucketsAvailableState) {
          return _buildLoaded(state.buckets);
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildLoaded(List<Bucket> buckets) {
    return ListView.separated(
      itemBuilder: (context, index) => BucketStatisticsListTile(
        bucket: buckets[index],
        receipts: receipts,
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: 8.0,
      ),
      itemCount: buckets.length,
    );
  }
}
