import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:equatable/equatable.dart';

abstract class TagsState extends Equatable {}

class TagsLoadingState extends TagsState {
  @override
  List<Object> get props => [];
}

class TagsAvailableState extends TagsState {

  final List<Tag> tags;

  TagsAvailableState(this.tags);

  @override
  List get props => [tags];

}