import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  final Function onTap;
  final Color selectedColor;

  const CustomChip(
      {Key key,
      this.text,
      this.icon,
      this.selected = false,
      this.onTap,
      this.selectedColor})
      : super(key: key);

  double get defaultBorderRadius => 12;

  static getDefaultSelectedColor(BuildContext context) =>
      Theme.of(context).primaryColor.withAlpha(50);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      onTap: onTap,
      child: Container(
        decoration: _getDecoration(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 6.0,
          ),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Color _getColor(BuildContext context) {
    if (selected) {
      return selectedColor ?? getDefaultSelectedColor(context);
    } else {
      return Colors.transparent;
    }
  }

  Widget _buildIconWithSpacing(BuildContext context) {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 8.0),
        ],
      );
    } else {
      return Container();
    }
  }

  BoxDecoration _getDecoration(BuildContext context) => BoxDecoration(
    borderRadius: BorderRadius.circular(defaultBorderRadius),
    boxShadow: [
      BoxShadow(
        color: _getColor(context),
        spreadRadius: 1,
        blurRadius: 1
      ),
    ]
  );

  Widget _buildContent(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIconWithSpacing(context),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
