import 'package:cash_box/data/datasources/datasource.dart';

abstract class Repository {

  Future<DataSource> get dataSource;

}