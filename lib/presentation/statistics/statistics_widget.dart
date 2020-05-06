import 'package:cash_box/presentation/widgets/custom_chip.dart';
import 'package:flutter/material.dart';

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
        children: [
          _buildBucketsTag(),
          SizedBox(width: 16.0),
          _buildTagsTag()
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: [Text("Test"), Text("Test2")],
      ),
    );
  }

  Widget _buildBucketsTag() {
    return AnimatedBuilder(
      animation: tabController.animation,
      builder: (_, __) {
        return CustomChip(
          text: "BUCKETS",
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
          text: "TAGS",
          selected: tabController.index == 1,
          icon: Icons.folder_open,
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
}
