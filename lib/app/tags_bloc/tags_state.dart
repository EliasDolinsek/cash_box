import 'package:equatable/equatable.dart';

abstract class TagsState extends Equatable {
  const TagsState();
}

class InitialTagsState extends TagsState {
  @override
  List<Object> get props => [];
}
