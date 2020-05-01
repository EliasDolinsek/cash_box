import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/receipt_month_bloc/bloc.dart';
import 'package:cash_box/app/receipt_month_bloc/receipt_month_bloc.dart';
import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/app/receipts_bloc/receipts_event.dart';
import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ReceiptMonthSelectionWidget extends StatefulWidget {
  @override
  _ReceiptMonthSelectionWidgetState createState() =>
      _ReceiptMonthSelectionWidgetState();
}

class _ReceiptMonthSelectionWidgetState
    extends State<ReceiptMonthSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = sl<ReceiptMonthBloc>();
    return StreamBuilder(
      stream: bloc.state,
      builder: (_, AsyncSnapshot<ReceiptMonthState> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is ReceiptMonthAvailableState) {
            return _buildLoaded(data);
          } else {
            return _buildLoading();
          }
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildLoading() {
    return SingleChildScrollView(
      child: LoadingWidget(),
    );
  }

  Widget _buildLoaded(ReceiptMonthAvailableState data) {
    final text = getMonthAsReadableReceiptMonth(data.month);
    return ActionChip(
      label: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      avatar: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColorDark,
        child: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      onPressed: () {
        _showReceiptMonthSelectionDialog(data.month);
      },
    );
  }

  void _showReceiptMonthSelectionDialog(DateTime initialMonth) async {
    final result =
        await showMonthPicker(context: context, initialDate: initialMonth);
    if (result != null) {
      final receiptsBlocEvent = GetReceiptsInReceiptMonthEvent(ReceiptMonth(result));
      sl<ReceiptsBloc>().dispatch(receiptsBlocEvent);
    }
  }
}
