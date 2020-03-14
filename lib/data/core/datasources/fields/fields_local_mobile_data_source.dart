import 'package:cash_box/data/core/datasources/datasource.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';

abstract class FieldsLocalMobileDataSource implements DataSource<Field> {

  Future<List<Field>> getFieldsWithIDs(List<String> ids);
}