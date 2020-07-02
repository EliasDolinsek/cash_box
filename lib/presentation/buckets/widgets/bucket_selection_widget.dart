import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/component_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BucketSelectionWidget extends StatefulWidget {
  final Bucket initialSelectedBucket;
  final Function(Bucket oldBucket, Bucket newBucket) onUpdated;

  const BucketSelectionWidget(
      {Key key, this.onUpdated, @required this.initialSelectedBucket})
      : super(key: key);

  @override
  _BucketSelectionWidgetState createState() => _BucketSelectionWidgetState();
}

class _BucketSelectionWidgetState extends State<BucketSelectionWidget> {
  Bucket selectedBucket;

  @override
  void initState() {
    super.initState();
    selectedBucket = widget.initialSelectedBucket;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl<BucketsBloc>(),
      builder: (context, state) {
        if (state is BucketsAvailableState) {
          if (state.buckets != null) {
            return _buildLoaded(context, state.buckets);
          } else {
            return LoadingWidget();
          }
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildLoaded(BuildContext context, List<Bucket> buckets) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Builder(
          builder: (context) {
            if (selectedBucket != null) {
              return Flexible(child: BucketListTile(bucket: selectedBucket));
            } else {
              return Text("No bucket selected");
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => Navigator.of(context).pushNamed(
            "/bucketSelection",
            arguments: {
              "initialSelectedBucketId": selectedBucket?.id,
              "onChanged": (newBucket) {
                widget.onUpdated(selectedBucket, newBucket);
                selectedBucket = newBucket;
              }
            },
          ),
        )
      ],
    );
  }
}
