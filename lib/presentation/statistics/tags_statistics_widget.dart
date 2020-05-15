import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_incomes_outcomes_use_case.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/statistics/statistics_list_tile.dart';
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
      itemBuilder: (_, index) => FutureBuilder<List<StatisticsListTileProgressIndicatorData>>(
        future: _getProgressIndicatorDataForTags(tags[index]),
        builder: (_, snapshot){
          if (snapshot.hasData){
            return StatisticsListTile(
              title: tags[index].name,
              trailing: "TODO!!!!!",
              progressIndicatorData: snapshot.data,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      separatorBuilder: (_, index) => SizedBox(height: 16.0),
      itemCount: tags.length,
    );
  }

  Future<List<StatisticsListTileProgressIndicatorData>>
      _getProgressIndicatorDataForTags(Tag tag) async {
    final receiptIds = receipts
        .where((element) => element.tagIDs.contains(tag.id))
        .map((e) => e.id)
        .toList();

    final params = GetIncomesOutcomesUseCaseParams(receiptIds, receipts);
    final result = await sl<GetIncomesOutcomesUseCase>().call(params);

    return result.fold((l) => null, (r) {
      if (r.incomeReceiptsAmount == 0 && r.outcomeReceiptsAmount == 0) {
        return [
          StatisticsListTileProgressIndicatorData.neutral(count: 0, text: "0€")
        ];
      } else {
        return [
          StatisticsListTileProgressIndicatorData.income(
              count: r.incomeReceiptsAmount,
              text: r.incomeReceiptsAmount.toString()),
          StatisticsListTileProgressIndicatorData.outcome(
              count: r.outcomeReceiptsAmount,
              text: r.outcomeReceiptsAmount.toString()),
        ];
      }
    });
  }
}
