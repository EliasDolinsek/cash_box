import 'dart:convert';

import 'package:cash_box/data/core/datasources/fields/fields_local_mobile_data_source.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:cash_box/data/core/datasources/templates/templates_local_mobile_data_source.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';

class TemplatesLocalMobileDataSourceMoorImpl implements TemplatesLocalMobileDataSource {

  final MoorAppDatabase database;
  final FieldsLocalMobileDataSource fieldsDataSource;

  TemplatesLocalMobileDataSourceMoorImpl(this.database, this.fieldsDataSource);

  @override
  Future<void> addType(Template type) async {
    final templatesMoorData = templatesMoorDataFromTemplate(type);
    await fieldsDataSource.addAllFields(type.fields);
    await database.addTemplate(templatesMoorData);
  }

  @override
  Future<List<Template>> getTypes() async {
    final templatesMoorDataList = await database.getAllTemplates();

    final templates = <Template>[];
    for(TemplatesMoorData templatesMoorData in templatesMoorDataList){
      final fieldsIDs = json.decode(templatesMoorData.fields).cast<String>();
      final fields = await fieldsDataSource.getFieldsWithIDs(fieldsIDs);

      final field = templateFromTemplatesMoorData(templatesMoorData, fields);
      templates.add(field);
    }

    return templates;
  }

  @override
  Future<void> removeType(String id) async {
    final templatesMoorData = await database.getTemplate(id);
    final fieldIDsAsList = json.decode(templatesMoorData.fields).cast<String>();
    await fieldsDataSource.removeAllFieldsWithIDs(fieldIDsAsList);
    await database.deleteTemplate(id);
  }

  @override
  Future<void> updateType(String id, Template update) async {
    final templatesMoorData = await database.getTemplate(id);
    final originalFieldIDsAsList = json.decode(templatesMoorData.fields).cast<String>();

    await fieldsDataSource.removeAllFieldsWithIDs(originalFieldIDsAsList);
    await fieldsDataSource.addAllFields(update.fields);

    final updatedTemplate = Template(id, name: update.name, fields: update.fields);
    await database.updateTemplate(templatesMoorDataFromTemplate(updatedTemplate));
  }

}