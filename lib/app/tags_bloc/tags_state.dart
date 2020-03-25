import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:equatable/equatable.dart';

abstract class TagsState extends Equatable {}

class InitialTagsState extends TagsState {
  @override
  List<Object> get props => [];
}

class TagsAvailableState extends TagsState {

  final List<Tag> tags;

  TagsAvailableState(this.tags);

  @override
  List get props => [tags];

}

class TagsUnavailableState extends TagsState {}

class TagsErrorState extends TagsState {

  final String errorMessage;

  TagsErrorState(this.errorMessage);

  @override
  List get props => [errorMessage];
}
