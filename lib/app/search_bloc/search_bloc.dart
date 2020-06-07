import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/domain/core/usecases/receipts/filter_receipts_use_case.dart';
import './bloc.dart';

import 'package:meta/meta.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final FilterReceiptsUseCase filterReceiptsUseCase;
  ReceiptsSearchEvent lastReceiptSearchEvent = ReceiptsSearchEvent();

  SearchBloc({@required this.filterReceiptsUseCase});

  @override
  SearchState get initialState => LoadingSearchState();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is ReceiptsSearchEvent) {
      yield LoadingSearchState();
      lastReceiptSearchEvent = event;
      yield await _searchReceipts(event);
    } else if(event is ReloadSearchEvent){
      yield LoadingSearchState();
      yield await _searchReceipts(lastReceiptSearchEvent);
    }
  }

  Future<SearchState> _searchReceipts(ReceiptsSearchEvent event) async {
    final params = FilterReceiptsUseCaseParams(
      text: event.text,
      tagIds: event.tagIds,
      receiptMonth: event.receiptMonth,
      receiptType: event.receiptType
    );

    final result = await filterReceiptsUseCase(params);
    return result.fold((l) {
      return ErrorSearchState(l.toString());
    }, (receipts) {
      return ReceiptsSearchAvailableState(receipts);
    });
  }
}
