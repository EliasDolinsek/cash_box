import 'package:cash_box/core/platform/constants.dart';
import 'package:flutter/material.dart';

class StatisticsListTile extends StatelessWidget {
  final String title;
  final String trailing;
  final List<StatisticsListTileProgressIndicatorData> progressIndicatorData;

  const StatisticsListTile(
      {Key key, this.title, this.trailing, this.progressIndicatorData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title ?? "",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          shadows: [Shadow(color: Colors.black, blurRadius: 1)],
        ),
      ),
      trailing: Text(
        trailing ?? "",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: _buildSubtitle(context),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    if (progressIndicatorData != null && progressIndicatorData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: _buildProgressIndicatorContainer(context),
      );
    } else {
      return Container();
    }
  }

  Widget _buildProgressIndicatorContainer(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: LayoutBuilder(
            builder: (_, constraints) {
              return _buildProgressIndicators(context, constraints.maxWidth);
            },
          ),
        ),
        Expanded(
          child: Container(),
          flex: 2,
        )
      ],
    );
  }

  Widget _buildProgressIndicators(BuildContext context, double maxWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: progressIndicatorData.where((e) => e.count != 0).map(
        (e) {
          return Padding(
            padding: EdgeInsets.only(right: indicatorsSpacing),
            child: Container(
              child: StatisticsListTileProgressIndicator(data: e),
              width: _getSpaceAsPercentOfProgressIndicatorData(e.count) *
                  _getMaxWidthForProgressIndicator(
                      maxWidth, indicatorsSpacing) /
                  100,
            ),
          );
        },
      ).toList(),
    );
  }

  double get indicatorsSpacing => 8;

  double _getMaxWidthForProgressIndicator(
      double maxWidth, double indicatorsSpacing) {
    if (progressIndicatorData.length == 0) {
      return maxWidth - indicatorsSpacing;
    } else {
      return maxWidth - (progressIndicatorData.length * indicatorsSpacing);
    }
  }

  double _getSpaceAsPercentOfProgressIndicatorData(double count) {
    if (_getProgressIndicatorDataMaxCount() == 0 || count == 0) return 100;
    return 100 / _getProgressIndicatorDataMaxCount() * count;
  }

  double _getProgressIndicatorDataMaxCount() {
    double count = 0;

    progressIndicatorData.forEach((element) {
      count += element.count;
    });

    return count;
  }
}

class StatisticsListTileProgressIndicator extends StatelessWidget {
  final StatisticsListTileProgressIndicatorData data;

  const StatisticsListTileProgressIndicator({Key key, @required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: data.color,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          data.text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

class StatisticsListTileProgressIndicatorData {
  final double count;
  final String text;
  final Color color;

  StatisticsListTileProgressIndicatorData(
      {@required this.count, @required this.text, @required this.color});

  factory StatisticsListTileProgressIndicatorData.income(
      {@required double count, @required String text}) {
    return StatisticsListTileProgressIndicatorData(
        count: count, text: text, color: incomeColor);
  }

  factory StatisticsListTileProgressIndicatorData.outcome(
      {@required double count, @required String text}) {
    return StatisticsListTileProgressIndicatorData(
        count: count, text: text, color: outcomeColor);
  }

  factory StatisticsListTileProgressIndicatorData.neutral(
      {@required double count, @required String text}) {
    return StatisticsListTileProgressIndicatorData(
        count: count, text: text, color: Colors.grey);
  }
}
