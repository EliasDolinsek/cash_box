import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/component_list_tile.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BucketsOverviewWidget extends StatefulWidget {
  @override
  _BucketsOverviewWidgetState createState() => _BucketsOverviewWidgetState();
}

class _BucketsOverviewWidgetState extends State<BucketsOverviewWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl<BucketsBloc>(),
      builder: (context, state) {
        if(state is BucketsAvailableState){
          final buckets = state.buckets;
          if(buckets == null || buckets.isEmpty){
            return _buildNoBuckets();
          } else {
            return BucketsOverviewListWidget(buckets);
          }
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildNoBuckets() {
    return Center(
      child: Text(AppLocalizations.translateOf(context, "txt_no_buckets")),
    );
  }
}

class BucketsOverviewListWidget extends StatelessWidget {

  final List<Bucket> buckets;

  const BucketsOverviewListWidget(this.buckets, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(child: _buildContent());
  }

  Widget _buildContent(){
    return Column(
      children: buckets.map((bucket) => BucketListTile(bucket: bucket)).toList(),
    );
  }
}