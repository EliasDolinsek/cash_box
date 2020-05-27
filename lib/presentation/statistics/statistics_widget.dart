import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/receipt_month_bloc/bloc.dart';
import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/statistics/bucket_statistics_widget.dart';
import 'package:cash_box/presentation/statistics/tags_statistics_widget.dart';
import 'package:cash_box/presentation/widgets/custom_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsWidget extends StatefulWidget {
  @override
  _StatisticsWidgetState createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPageSelection(),
        _buildContent(),
      ],
    );
  }

  Widget _buildPageSelection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [_buildBucketsTag(), SizedBox(width: 16.0), _buildTagsTag()],
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder(
      bloc: sl<ReceiptsBloc>(),
      builder: (_, state){
        if(state is ReceiptsInReceiptMonthAvailableState){
          return _buildLoaded(state.receipts);
        } else if(state is ReceiptsAvailableState){
          return _buildLoaded(state.receipts);
        } else if(state is ReceiptsErrorState){
          return Text(state.errorMessage);
        } else {
          _loadReceipts();
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildLoaded(List<Receipt> receipts){
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: [
          BucketStatisticsWidget(receipts: receipts),
          TagsStatisticsWidget(receipts: receipts),
        ],
      ),
    );
  }

  Widget _buildBucketsTag() {
    return AnimatedBuilder(
      animation: tabController.animation,
      builder: (_, __) {
        return CustomChip(
          text: AppLocalizations.translateOf(context, "btn_buckets"),
          selected: tabController.index == 0,
          icon: Icons.folder_open,
          selectedColor: Theme.of(context)
              .primaryColor
              .withAlpha((50 * (1 - tabController.animation.value)).toInt()),
          onTap: () {
            tabController.animateTo(0);
          },
        );
      },
    );
  }

  Widget _buildTagsTag() {
    return AnimatedBuilder(
      animation: tabController.animation,
      builder: (_, __) {
        return CustomChip(
          text: AppLocalizations.translateOf(context, "btn_tags"),
          selected: tabController.index == 1,
          icon: Icons.label_outline,
          selectedColor: Theme.of(context)
              .primaryColor
              .withAlpha((50 * tabController.animation.value).toInt()),
          onTap: () {
            tabController.animateTo(1);
          },
        );
      },
    );
  }

  void _loadReceipts() async {
    final state = await sl<ReceiptMonthBloc>().state.first;
    if(state is ReceiptMonthAvailableState){
      final receiptMonth = ReceiptMonth(state.month);
      sl<ReceiptsBloc>().dispatch(GetReceiptsInReceiptMonthEvent(receiptMonth));
    }
  }
}