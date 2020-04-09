import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/buckets/buckets_card_widget.dart';
import 'package:flutter/material.dart';

class OverviewWidget extends StatefulWidget {
  @override
  _OverviewWidgetState createState() => _OverviewWidgetState();
}

class _OverviewWidgetState extends State<OverviewWidget> {
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
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 800
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent(){
    return ListView.separated(
      padding: EdgeInsets.all(4.0),
      itemCount: buckets.length,
      itemBuilder: (_, index) => BucketListItemCardWidget(buckets[index]),
      separatorBuilder: (_, __) => SizedBox(height: 0.0),
    );
  }
}