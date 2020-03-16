import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/add_tag_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/get_tag_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/get_tags_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/remove_tag_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/update_tag_use_case.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  final AddTagUseCase addTagUseCase;
  final GetTagUseCase getTagUseCase;
  final GetTagsUseCase getTagsUseCase;
  final RemoveTagUseCase removeTagUseCase;
  final UpdateTagUseCase updateTagUseCase;

  TagsBloc(
      {@required this.addTagUseCase,
      @required this.getTagUseCase,
      @required this.getTagsUseCase,
      @required this.removeTagUseCase,
      @required this.updateTagUseCase});

  @override
  TagsState get initialState => InitialTagsState();

  @override
  Stream<TagsState> mapEventToState(
    TagsEvent event,
  ) async* {
    if (event is AddTagEvent) {
      final params = AddTagUseCaseParams(event.tag);
      await addTagUseCase(params);
    } else if (event is GetTagEvent) {
      yield await _getTag(event);
    } else if (event is GetTagsEvent) {
      yield await _getTags();
    } else if (event is RemoveTagEvent) {
      final params = RemoveTagUseCaseParams(event.tagID);
      await removeTagUseCase(params);
    } else if (event is UpdateTagEvent) {
      final params = UpdateTagUseCaseParams(event.id,
          name: event.name, color: event.color);
      await updateTagUseCase(params);
    }
  }

  Future<TagsState> _getTag(GetTagEvent event) async {
    final params = GetTagUseCaseParams(event.tagID);
    final tagEither = await getTagUseCase(params);
    return tagEither.fold((l) => TagsErrorState(l.toString()), (tag) {
      return TagAvailableState(tag);
    });
  }

  Future<TagsState> _getTags() async {
    final tagsEither = await getTagsUseCase(NoParams());
    return tagsEither.fold((l) => TagsErrorState(l.toString()), (tags) {
      return TagsAvailableState(tags);
    });
  }
}
