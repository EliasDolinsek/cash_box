import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/buckets/widgets/bucket_list_item.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

class BucketsOverviewWidget extends StatefulWidget {
  @override
  _BucketsOverviewWidgetState createState() => _BucketsOverviewWidgetState();
}

class _BucketsOverviewWidgetState extends State<BucketsOverviewWidget> {
  @override
  Widget build(BuildContext context) {
    final bucketsBloc = sl<BucketsBloc>();
    return StreamBuilder(
      stream: bucketsBloc.state,
      builder: (_, AsyncSnapshot<BucketsState> snapshot){
        if(snapshot.hasData){
          final data = snapshot.data;
          if(data is BucketsAvailableState){
            final buckets = data.buckets;
            if(buckets == null || buckets.isEmpty){
              return _buildNoBuckets();
            } else {
              return BucketsOverviewListWidget(data.buckets);
            }
          } else if(data is BucketsErrorState){
            return ErrorWidget(data.errorMessage);
          } else {
            bucketsBloc.dispatch(GetBucketsEvent());
            return LoadingWidget();
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
      children: buckets.map((bucket) => BucketListItem(bucket)).toList(),
    );
  }
}