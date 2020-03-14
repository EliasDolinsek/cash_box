import 'package:cash_box/data/core/datasources/fields/fields_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';

class FieldsLocalMobileDataSourceMoorImpl extends FieldsLocalMobileDataSource {

  final MoorAppDatabase appDatabase;

  FieldsLocalMobileDataSourceMoorImpl(this.appDatabase);

  @override
  Future<void> addType(Field type) async {
    final fieldsMoorData = fieldsMoorDataFromField(type);
    await appDatabase.addField(fieldsMoorData);
  }

  @override
  Future<List<Field>> getTypes() async {
    final fieldsMoorData = await appDatabase.getAllFields();
    return fieldsMoorData.map((e) => fieldFromFieldsMoorData(e)).toList();
  }

  @override
  Future<void> removeType(String id) async {
    await appDatabase.deleteField(id);
  }

  @override
  Future<void> updateType(String id, Field field) async {
    final update = Field(id,
        type: field.type, description: field.description, value: field.value);

    await appDatabase.updateField(fieldsMoorDataFromField(update));
  }

  @override
  Future<List<Field>> getFieldsWithIDs(List<String> ids) async{
    final allFields = await getTypes();
    return allFields.where((element) => ids.contains(element.id)).toList();
  }

  @override
  Future addAllFields(List<Field> fields) async {
    for(Field field in fields){
      await addType(field);
    }
  }

  @override
  Future removeAllFieldsWithIDs(List<String> ids) async {
    for(String id in ids){
      await removeType(id);
    }
  }
}
