import 'package:cash_box/data/core/datasources/moor_databases/moor_app_database.dart';
import 'package:cash_box/data/core/datasources/moor_databases/moor_data_converter.dart';
import 'package:cash_box/data/core/datasources/tags/tags_local_mobile_data_source.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';

class TagsLocalMobileDataSourceMoorImpl implements TagsLocalMobileDataSource {

  final MoorAppDatabase appDatabase;

  TagsLocalMobileDataSourceMoorImpl(this.appDatabase);

  @override
  Future<void> addType(Tag type) async {
    final tagsMoorData = tagsMoorDataFromTag(type);
    await appDatabase.addTag(tagsMoorData);
  }

  @override
  Future<List<Tag>> getTypes() async {
    final tagsMoorDataList = await appDatabase.getAllTags();
    final tagsList = tagsMoorDataList.map((e) => tagFromTagsMoorData(e)).toList();
    return tagsList;
  }

  @override
  Future<void> removeType(String id) async {
    await appDatabase.deleteTag(id);
  }

  @override
  Future<void> updateType(String id, Tag tag) async {
    final update = Tag(id, name: tag.name, color: tag.color);
    await appDatabase.updateTag(tagsMoorDataFromTag(update));
  }

  @override
  void clear() {
    // Nothing to clear
  }
}