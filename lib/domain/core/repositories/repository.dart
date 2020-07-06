import 'package:cash_box/data/core/datasources/datasource.dart';

abstract class Repository {

  Future<DataSource> get dataSource;
  void notifyUserIdChanged(String userId);
}