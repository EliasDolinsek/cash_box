import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:equatable/equatable.dart';

abstract class TagsEvent extends Equatable {}

class AddTagEvent extends TagsEvent {

  final Tag tag;

  AddTagEvent(this.tag);

  @override
  List get props => [tag];
}

class GetTagEvent extends TagsEvent {
  final String bucketID;

  GetTagEvent(this.bucketID);

  @override
  List get props => [bucketID];
}

class GetTagsEvent extends TagsEvent {}

class RemoveTagEvent extends TagsEvent {

  final String bucketID;

  RemoveTagEvent(this.bucketID);

  @override
  List get props => [bucketID];
}

class UpdateTagEvent extends TagsEvent {

  final String id;
  final String name, description;
  final List<String> receiptIDs;

  UpdateTagEvent({this.id, this.name, this.description, this.receiptIDs});

  @override
  List get props => [id, name, description, receiptIDs];
}
