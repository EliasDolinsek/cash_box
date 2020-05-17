import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_incomes_outcomes_use_case.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/statistics/statistics_list_tile/statistics_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagsStatisticsWidget extends StatelessWidget {
  final List<Receipt> receipts;

  const TagsStatisticsWidget({Key key, @required this.receipts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl<TagsBloc>(),
      builder: (_, state) {
        if (state is TagsAvailableState) {
          return _buildLoaded(state.tags);
        } else if (state is TagsUnavailableState) {
          sl<TagsBloc>().dispatch(GetTagsEvent());
          return LoadingWidget();
        } else if (state is TagsErrorState) {
          return ErrorWidget(state.errorMessage);
        } else {
          sl<TagsBloc>().dispatch(GetTagsEvent());
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildLoaded(List<Tag> tags) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, index) => TagStatisticsListTile(
        receipts: receipts,
        tag: tags[index],
      ),
      separatorBuilder: (_, index) => SizedBox(height: 16.0),
      itemCount: tags.length,
    );
  }
}
