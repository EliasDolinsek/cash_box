import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/statistics/statistics_list_tile.dart';
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
        if (state is InitialBucketsState) {
          sl<BucketsBloc>().dispatch(GetBucketsEvent());
          return LoadingWidget();
        } else if (state is BucketsAvailableState) {
          return _buildLoaded(state.buckets);
        } else if (state is BucketsErrorState) {
          return ErrorWidget(state.errorMessage);
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildLoaded(List<Bucket> buckets) {
    return ListView.separated(
      itemBuilder: (_, index) => StatisticsListTile(
        title: buckets[index].name,
        trailing: "+200€",
        progressIndicatorData: [
          StatisticsListTileProgressIndicatorData.income(count: 200, text: "+320€"),
          StatisticsListTileProgressIndicatorData.neutral(count: 100, text: "+320€"),
          StatisticsListTileProgressIndicatorData.neutral(count: 100, text: "+320€"),
        ],
      ),
      separatorBuilder: (_, index) => SizedBox(height: 16.0),
      itemCount: buckets.length,
    );
  }
}
