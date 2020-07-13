import 'dart:convert' show json;

import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/buckets/add_bucket_use_case.dart';
import 'package:cash_box/domain/core/usecases/tags/add_tag_use_case.dart';
import 'package:cash_box/domain/core/usecases/templates/add_template_use_case.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:flutter/services.dart' show rootBundle;

class AddDefaultComponentsUseCase
    extends SecureSyncUseCase<EmptyData, NoParams> {
  final AddBucketUseCase addBucketUseCase;
  final AddTemplateUseCase addTemplateUseCase;
  final AddTagUseCase addTagUseCase;

  AddDefaultComponentsUseCase(
      this.addBucketUseCase, this.addTemplateUseCase, this.addTagUseCase);

  @override
  EmptyData call(NoParams params) {
    try {
      _addDefaultBuckets();
      _addDefaultTemplates();
      _addDefaultTags();
    } on Exception catch (e) {
      print(e);
    }
    return EmptyData();
  }

  void _addDefaultBuckets() async {
    final bucketsAsJsonString =
        await rootBundle.loadString("assets/default_data/default_buckets.json");
    for (Bucket bucket
        in _getDefaultBucketsFromBucketsJsonString(bucketsAsJsonString)) {
      addBucketUseCase.call(AddBucketUseCaseParams(bucket));
    }
  }

  List<Bucket> _getDefaultBucketsFromBucketsJsonString(String bucketsAsJson) {
    final defaultBucketsAsJson = json.decode(bucketsAsJson);

    return (defaultBucketsAsJson["buckets"] as List)
        .map((e) => Bucket.fromJson(e))
        .toList();
  }

  void _addDefaultTemplates() async {
    final templatesAsJsonString = await rootBundle
        .loadString("assets/default_data/default_templates.json");
    for (Template template
        in _getDefaultTemplatesFromTemplatesJsonString(templatesAsJsonString)) {
      addTemplateUseCase.call(AddTemplateUseCaseParams(template));
    }
  }

  List<Template> _getDefaultTemplatesFromTemplatesJsonString(
      String templatesAsJsonString) {
    final defaultTemplatesJson = json.decode(templatesAsJsonString);

    return (defaultTemplatesJson["templates"] as List)
        .map((e) => Template.fromJson(e))
        .toList();
  }

  void _addDefaultTags() async {
    final tagsAsJsonString =
        await rootBundle.loadString("assets/default_data/default_tags.json");

    for (Tag tag in _getDefaultTagsFromTagsJsonString(tagsAsJsonString)) {
      addTagUseCase.call(AddTagUseCaseParams(tag));
    }
  }

  List<Tag> _getDefaultTagsFromTagsJsonString(String tagsAsJsonString) {
    final defaultTagsJson = json.decode(tagsAsJsonString);

    return (defaultTagsJson["tags"] as List)
        .map((e) => Tag.fromJson(e))
        .toList();
  }
}
