import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  @override
  TagsState get initialState => InitialTagsState();

  @override
  Stream<TagsState> mapEventToState(
    TagsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
