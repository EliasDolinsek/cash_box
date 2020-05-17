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
    /*return ListView.separated(
      itemBuilder: (_, index) => FutureBuilder<List<StatisticsListTileProgressIndicatorData>>(
        future: _getProgressIndicatorDataForBucket(buckets[index]),
        builder: (_, snapshot){
          if (snapshot.hasData){
            return StatisticsListTile(
              title: buckets[index].name,
              trailing: "TODO!!!!!",
              progressIndicatorData: snapshot.data,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      separatorBuilder: (_, index) => SizedBox(height: 16.0),
      itemCount: buckets.length,
    );*/
    return Text("LOADED");
  }
}
