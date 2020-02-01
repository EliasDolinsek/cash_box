import 'package:equatable/equatable.dart';

class UniqueComponent extends Equatable{

  final String id;

  UniqueComponent(this.id, {List<dynamic> params = const[]}) : super([params, id]);

}