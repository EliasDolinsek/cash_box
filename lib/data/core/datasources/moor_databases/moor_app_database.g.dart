// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class BucketsMoorData extends DataClass implements Insertable<BucketsMoorData> {
  final String id;
  final String description;
  final String name;
  final String receiptsIDs;
  BucketsMoorData(
      {@required this.id,
      @required this.description,
      @required this.name,
      @required this.receiptsIDs});
  factory BucketsMoorData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return BucketsMoorData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      receiptsIDs: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}receipts_i_ds']),
    );
  }
  factory BucketsMoorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BucketsMoorData(
      id: serializer.fromJson<String>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      name: serializer.fromJson<String>(json['name']),
      receiptsIDs: serializer.fromJson<String>(json['receiptsIDs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'description': serializer.toJson<String>(description),
      'name': serializer.toJson<String>(name),
      'receiptsIDs': serializer.toJson<String>(receiptsIDs),
    };
  }

  @override
  BucketsMoorCompanion createCompanion(bool nullToAbsent) {
    return BucketsMoorCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      receiptsIDs: receiptsIDs == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptsIDs),
    );
  }

  BucketsMoorData copyWith(
          {String id, String description, String name, String receiptsIDs}) =>
      BucketsMoorData(
        id: id ?? this.id,
        description: description ?? this.description,
        name: name ?? this.name,
        receiptsIDs: receiptsIDs ?? this.receiptsIDs,
      );
  @override
  String toString() {
    return (StringBuffer('BucketsMoorData(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('name: $name, ')
          ..write('receiptsIDs: $receiptsIDs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(description.hashCode, $mrjc(name.hashCode, receiptsIDs.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is BucketsMoorData &&
          other.id == this.id &&
          other.description == this.description &&
          other.name == this.name &&
          other.receiptsIDs == this.receiptsIDs);
}

class BucketsMoorCompanion extends UpdateCompanion<BucketsMoorData> {
  final Value<String> id;
  final Value<String> description;
  final Value<String> name;
  final Value<String> receiptsIDs;
  const BucketsMoorCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.name = const Value.absent(),
    this.receiptsIDs = const Value.absent(),
  });
  BucketsMoorCompanion.insert({
    @required String id,
    this.description = const Value.absent(),
    this.name = const Value.absent(),
    this.receiptsIDs = const Value.absent(),
  }) : id = Value(id);
  BucketsMoorCompanion copyWith(
      {Value<String> id,
      Value<String> description,
      Value<String> name,
      Value<String> receiptsIDs}) {
    return BucketsMoorCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      name: name ?? this.name,
      receiptsIDs: receiptsIDs ?? this.receiptsIDs,
    );
  }
}

class $BucketsMoorTable extends BucketsMoor
    with TableInfo<$BucketsMoorTable, BucketsMoorData> {
  final GeneratedDatabase _db;
  final String _alias;
  $BucketsMoorTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        defaultValue: Constant(""));
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        defaultValue: Constant(""));
  }

  final VerificationMeta _receiptsIDsMeta =
      const VerificationMeta('receiptsIDs');
  GeneratedTextColumn _receiptsIDs;
  @override
  GeneratedTextColumn get receiptsIDs =>
      _receiptsIDs ??= _constructReceiptsIDs();
  GeneratedTextColumn _constructReceiptsIDs() {
    return GeneratedTextColumn('receipts_i_ds', $tableName, false,
        defaultValue: Constant(""));
  }

  @override
  List<GeneratedColumn> get $columns => [id, description, name, receiptsIDs];
  @override
  $BucketsMoorTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'buckets_moor';
  @override
  final String actualTableName = 'buckets_moor';
  @override
  VerificationContext validateIntegrity(BucketsMoorCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    }
    if (d.receiptsIDs.present) {
      context.handle(_receiptsIDsMeta,
          receiptsIDs.isAcceptableValue(d.receiptsIDs.value, _receiptsIDsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BucketsMoorData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return BucketsMoorData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(BucketsMoorCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.receiptsIDs.present) {
      map['receipts_i_ds'] = Variable<String, StringType>(d.receiptsIDs.value);
    }
    return map;
  }

  @override
  $BucketsMoorTable createAlias(String alias) {
    return $BucketsMoorTable(_db, alias);
  }
}

class ContactsMoorData extends DataClass
    implements Insertable<ContactsMoorData> {
  final String id;
  final String name;
  final String fieldIDs;
  ContactsMoorData(
      {@required this.id, @required this.name, @required this.fieldIDs});
  factory ContactsMoorData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ContactsMoorData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      fieldIDs: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}field_i_ds']),
    );
  }
  factory ContactsMoorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ContactsMoorData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      fieldIDs: serializer.fromJson<String>(json['fieldIDs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'fieldIDs': serializer.toJson<String>(fieldIDs),
    };
  }

  @override
  ContactsMoorCompanion createCompanion(bool nullToAbsent) {
    return ContactsMoorCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      fieldIDs: fieldIDs == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldIDs),
    );
  }

  ContactsMoorData copyWith({String id, String name, String fieldIDs}) =>
      ContactsMoorData(
        id: id ?? this.id,
        name: name ?? this.name,
        fieldIDs: fieldIDs ?? this.fieldIDs,
      );
  @override
  String toString() {
    return (StringBuffer('ContactsMoorData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('fieldIDs: $fieldIDs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, fieldIDs.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ContactsMoorData &&
          other.id == this.id &&
          other.name == this.name &&
          other.fieldIDs == this.fieldIDs);
}

class ContactsMoorCompanion extends UpdateCompanion<ContactsMoorData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> fieldIDs;
  const ContactsMoorCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.fieldIDs = const Value.absent(),
  });
  ContactsMoorCompanion.insert({
    @required String id,
    this.name = const Value.absent(),
    this.fieldIDs = const Value.absent(),
  }) : id = Value(id);
  ContactsMoorCompanion copyWith(
      {Value<String> id, Value<String> name, Value<String> fieldIDs}) {
    return ContactsMoorCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      fieldIDs: fieldIDs ?? this.fieldIDs,
    );
  }
}

class $ContactsMoorTable extends ContactsMoor
    with TableInfo<$ContactsMoorTable, ContactsMoorData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ContactsMoorTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        defaultValue: Constant(""));
  }

  final VerificationMeta _fieldIDsMeta = const VerificationMeta('fieldIDs');
  GeneratedTextColumn _fieldIDs;
  @override
  GeneratedTextColumn get fieldIDs => _fieldIDs ??= _constructFieldIDs();
  GeneratedTextColumn _constructFieldIDs() {
    return GeneratedTextColumn('field_i_ds', $tableName, false,
        defaultValue: Constant(""));
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, fieldIDs];
  @override
  $ContactsMoorTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'contacts_moor';
  @override
  final String actualTableName = 'contacts_moor';
  @override
  VerificationContext validateIntegrity(ContactsMoorCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    }
    if (d.fieldIDs.present) {
      context.handle(_fieldIDsMeta,
          fieldIDs.isAcceptableValue(d.fieldIDs.value, _fieldIDsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactsMoorData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ContactsMoorData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ContactsMoorCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.fieldIDs.present) {
      map['field_i_ds'] = Variable<String, StringType>(d.fieldIDs.value);
    }
    return map;
  }

  @override
  $ContactsMoorTable createAlias(String alias) {
    return $ContactsMoorTable(_db, alias);
  }
}

class FieldsMoorData extends DataClass implements Insertable<FieldsMoorData> {
  final String id;
  final String description;
  final String type;
  final String value;
  final bool storageOnly;
  FieldsMoorData(
      {@required this.id,
      @required this.description,
      @required this.type,
      @required this.value,
      @required this.storageOnly});
  factory FieldsMoorData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return FieldsMoorData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      value:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
      storageOnly: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}storage_only']),
    );
  }
  factory FieldsMoorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FieldsMoorData(
      id: serializer.fromJson<String>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      type: serializer.fromJson<String>(json['type']),
      value: serializer.fromJson<String>(json['value']),
      storageOnly: serializer.fromJson<bool>(json['storageOnly']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'description': serializer.toJson<String>(description),
      'type': serializer.toJson<String>(type),
      'value': serializer.toJson<String>(value),
      'storageOnly': serializer.toJson<bool>(storageOnly),
    };
  }

  @override
  FieldsMoorCompanion createCompanion(bool nullToAbsent) {
    return FieldsMoorCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      storageOnly: storageOnly == null && nullToAbsent
          ? const Value.absent()
          : Value(storageOnly),
    );
  }

  FieldsMoorData copyWith(
          {String id,
          String description,
          String type,
          String value,
          bool storageOnly}) =>
      FieldsMoorData(
        id: id ?? this.id,
        description: description ?? this.description,
        type: type ?? this.type,
        value: value ?? this.value,
        storageOnly: storageOnly ?? this.storageOnly,
      );
  @override
  String toString() {
    return (StringBuffer('FieldsMoorData(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('storageOnly: $storageOnly')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(description.hashCode,
          $mrjc(type.hashCode, $mrjc(value.hashCode, storageOnly.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is FieldsMoorData &&
          other.id == this.id &&
          other.description == this.description &&
          other.type == this.type &&
          other.value == this.value &&
          other.storageOnly == this.storageOnly);
}

class FieldsMoorCompanion extends UpdateCompanion<FieldsMoorData> {
  final Value<String> id;
  final Value<String> description;
  final Value<String> type;
  final Value<String> value;
  final Value<bool> storageOnly;
  const FieldsMoorCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.storageOnly = const Value.absent(),
  });
  FieldsMoorCompanion.insert({
    @required String id,
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    @required bool storageOnly,
  })  : id = Value(id),
        storageOnly = Value(storageOnly);
  FieldsMoorCompanion copyWith(
      {Value<String> id,
      Value<String> description,
      Value<String> type,
      Value<String> value,
      Value<bool> storageOnly}) {
    return FieldsMoorCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      type: type ?? this.type,
      value: value ?? this.value,
      storageOnly: storageOnly ?? this.storageOnly,
    );
  }
}

class $FieldsMoorTable extends FieldsMoor
    with TableInfo<$FieldsMoorTable, FieldsMoorData> {
  final GeneratedDatabase _db;
  final String _alias;
  $FieldsMoorTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        defaultValue: Constant(""));
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn('type', $tableName, false,
        defaultValue: Constant(""));
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedTextColumn _value;
  @override
  GeneratedTextColumn get value => _value ??= _constructValue();
  GeneratedTextColumn _constructValue() {
    return GeneratedTextColumn('value', $tableName, false,
        defaultValue: Constant(""));
  }

  final VerificationMeta _storageOnlyMeta =
      const VerificationMeta('storageOnly');
  GeneratedBoolColumn _storageOnly;
  @override
  GeneratedBoolColumn get storageOnly =>
      _storageOnly ??= _constructStorageOnly();
  GeneratedBoolColumn _constructStorageOnly() {
    return GeneratedBoolColumn(
      'storage_only',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, description, type, value, storageOnly];
  @override
  $FieldsMoorTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'fields_moor';
  @override
  final String actualTableName = 'fields_moor';
  @override
  VerificationContext validateIntegrity(FieldsMoorCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    }
    if (d.type.present) {
      context.handle(
          _typeMeta, type.isAcceptableValue(d.type.value, _typeMeta));
    }
    if (d.value.present) {
      context.handle(
          _valueMeta, value.isAcceptableValue(d.value.value, _valueMeta));
    }
    if (d.storageOnly.present) {
      context.handle(_storageOnlyMeta,
          storageOnly.isAcceptableValue(d.storageOnly.value, _storageOnlyMeta));
    } else if (isInserting) {
      context.missing(_storageOnlyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FieldsMoorData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return FieldsMoorData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(FieldsMoorCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.type.present) {
      map['type'] = Variable<String, StringType>(d.type.value);
    }
    if (d.value.present) {
      map['value'] = Variable<String, StringType>(d.value.value);
    }
    if (d.storageOnly.present) {
      map['storage_only'] = Variable<bool, BoolType>(d.storageOnly.value);
    }
    return map;
  }

  @override
  $FieldsMoorTable createAlias(String alias) {
    return $FieldsMoorTable(_db, alias);
  }
}

class ReceiptsMoorData extends DataClass
    implements Insertable<ReceiptsMoorData> {
  final String id;
  final String type;
  final DateTime creationDate;
  final String fieldIDs;
  final String tagIDs;
  ReceiptsMoorData(
      {@required this.id,
      @required this.type,
      @required this.creationDate,
      @required this.fieldIDs,
      @required this.tagIDs});
  factory ReceiptsMoorData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return ReceiptsMoorData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      creationDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}creation_date']),
      fieldIDs: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}field_i_ds']),
      tagIDs: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_i_ds']),
    );
  }
  factory ReceiptsMoorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ReceiptsMoorData(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      creationDate: serializer.fromJson<DateTime>(json['creationDate']),
      fieldIDs: serializer.fromJson<String>(json['fieldIDs']),
      tagIDs: serializer.fromJson<String>(json['tagIDs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'creationDate': serializer.toJson<DateTime>(creationDate),
      'fieldIDs': serializer.toJson<String>(fieldIDs),
      'tagIDs': serializer.toJson<String>(tagIDs),
    };
  }

  @override
  ReceiptsMoorCompanion createCompanion(bool nullToAbsent) {
    return ReceiptsMoorCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      creationDate: creationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(creationDate),
      fieldIDs: fieldIDs == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldIDs),
      tagIDs:
          tagIDs == null && nullToAbsent ? const Value.absent() : Value(tagIDs),
    );
  }

  ReceiptsMoorData copyWith(
          {String id,
          String type,
          DateTime creationDate,
          String fieldIDs,
          String tagIDs}) =>
      ReceiptsMoorData(
        id: id ?? this.id,
        type: type ?? this.type,
        creationDate: creationDate ?? this.creationDate,
        fieldIDs: fieldIDs ?? this.fieldIDs,
        tagIDs: tagIDs ?? this.tagIDs,
      );
  @override
  String toString() {
    return (StringBuffer('ReceiptsMoorData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('creationDate: $creationDate, ')
          ..write('fieldIDs: $fieldIDs, ')
          ..write('tagIDs: $tagIDs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          type.hashCode,
          $mrjc(creationDate.hashCode,
              $mrjc(fieldIDs.hashCode, tagIDs.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ReceiptsMoorData &&
          other.id == this.id &&
          other.type == this.type &&
          other.creationDate == this.creationDate &&
          other.fieldIDs == this.fieldIDs &&
          other.tagIDs == this.tagIDs);
}

class ReceiptsMoorCompanion extends UpdateCompanion<ReceiptsMoorData> {
  final Value<String> id;
  final Value<String> type;
  final Value<DateTime> creationDate;
  final Value<String> fieldIDs;
  final Value<String> tagIDs;
  const ReceiptsMoorCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.creationDate = const Value.absent(),
    this.fieldIDs = const Value.absent(),
    this.tagIDs = const Value.absent(),
  });
  ReceiptsMoorCompanion.insert({
    @required String id,
    this.type = const Value.absent(),
    @required DateTime creationDate,
    this.fieldIDs = const Value.absent(),
    this.tagIDs = const Value.absent(),
  })  : id = Value(id),
        creationDate = Value(creationDate);
  ReceiptsMoorCompanion copyWith(
      {Value<String> id,
      Value<String> type,
      Value<DateTime> creationDate,
      Value<String> fieldIDs,
      Value<String> tagIDs}) {
    return ReceiptsMoorCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      creationDate: creationDate ?? this.creationDate,
      fieldIDs: fieldIDs ?? this.fieldIDs,
      tagIDs: tagIDs ?? this.tagIDs,
    );
  }
}

class $ReceiptsMoorTable extends ReceiptsMoor
    with TableInfo<$ReceiptsMoorTable, ReceiptsMoorData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ReceiptsMoorTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn('type', $tableName, false,
        defaultValue: Constant(""));
  }

  final VerificationMeta _creationDateMeta =
      const VerificationMeta('creationDate');
  GeneratedDateTimeColumn _creationDate;
  @override
  GeneratedDateTimeColumn get creationDate =>
      _creationDate ??= _constructCreationDate();
  GeneratedDateTimeColumn _constructCreationDate() {
    return GeneratedDateTimeColumn(
      'creation_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fieldIDsMeta = const VerificationMeta('fieldIDs');
  GeneratedTextColumn _fieldIDs;
  @override
  GeneratedTextColumn get fieldIDs => _fieldIDs ??= _constructFieldIDs();
  GeneratedTextColumn _constructFieldIDs() {
    return GeneratedTextColumn('field_i_ds', $tableName, false,
        defaultValue: Constant(""));
  }

  final VerificationMeta _tagIDsMeta = const VerificationMeta('tagIDs');
  GeneratedTextColumn _tagIDs;
  @override
  GeneratedTextColumn get tagIDs => _tagIDs ??= _constructTagIDs();
  GeneratedTextColumn _constructTagIDs() {
    return GeneratedTextColumn('tag_i_ds', $tableName, false,
        defaultValue: Constant(""));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, type, creationDate, fieldIDs, tagIDs];
  @override
  $ReceiptsMoorTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'receipts_moor';
  @override
  final String actualTableName = 'receipts_moor';
  @override
  VerificationContext validateIntegrity(ReceiptsMoorCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.type.present) {
      context.handle(
          _typeMeta, type.isAcceptableValue(d.type.value, _typeMeta));
    }
    if (d.creationDate.present) {
      context.handle(
          _creationDateMeta,
          creationDate.isAcceptableValue(
              d.creationDate.value, _creationDateMeta));
    } else if (isInserting) {
      context.missing(_creationDateMeta);
    }
    if (d.fieldIDs.present) {
      context.handle(_fieldIDsMeta,
          fieldIDs.isAcceptableValue(d.fieldIDs.value, _fieldIDsMeta));
    }
    if (d.tagIDs.present) {
      context.handle(
          _tagIDsMeta, tagIDs.isAcceptableValue(d.tagIDs.value, _tagIDsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReceiptsMoorData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ReceiptsMoorData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ReceiptsMoorCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.type.present) {
      map['type'] = Variable<String, StringType>(d.type.value);
    }
    if (d.creationDate.present) {
      map['creation_date'] =
          Variable<DateTime, DateTimeType>(d.creationDate.value);
    }
    if (d.fieldIDs.present) {
      map['field_i_ds'] = Variable<String, StringType>(d.fieldIDs.value);
    }
    if (d.tagIDs.present) {
      map['tag_i_ds'] = Variable<String, StringType>(d.tagIDs.value);
    }
    return map;
  }

  @override
  $ReceiptsMoorTable createAlias(String alias) {
    return $ReceiptsMoorTable(_db, alias);
  }
}

class TagsMoorData extends DataClass implements Insertable<TagsMoorData> {
  final String id;
  final String name;
  final String color;
  TagsMoorData({@required this.id, @required this.name, @required this.color});
  factory TagsMoorData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return TagsMoorData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      color:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }
  factory TagsMoorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TagsMoorData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
    };
  }

  @override
  TagsMoorCompanion createCompanion(bool nullToAbsent) {
    return TagsMoorCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  TagsMoorData copyWith({String id, String name, String color}) => TagsMoorData(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('TagsMoorData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, color.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TagsMoorData &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color);
}

class TagsMoorCompanion extends UpdateCompanion<TagsMoorData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> color;
  const TagsMoorCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  });
  TagsMoorCompanion.insert({
    @required String id,
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  }) : id = Value(id);
  TagsMoorCompanion copyWith(
      {Value<String> id, Value<String> name, Value<String> color}) {
    return TagsMoorCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }
}

class $TagsMoorTable extends TagsMoor
    with TableInfo<$TagsMoorTable, TagsMoorData> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsMoorTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        defaultValue: Constant(""));
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedTextColumn _color;
  @override
  GeneratedTextColumn get color => _color ??= _constructColor();
  GeneratedTextColumn _constructColor() {
    return GeneratedTextColumn('color', $tableName, false,
        defaultValue: Constant(""));
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, color];
  @override
  $TagsMoorTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags_moor';
  @override
  final String actualTableName = 'tags_moor';
  @override
  VerificationContext validateIntegrity(TagsMoorCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    }
    if (d.color.present) {
      context.handle(
          _colorMeta, color.isAcceptableValue(d.color.value, _colorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagsMoorData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TagsMoorData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TagsMoorCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.color.present) {
      map['color'] = Variable<String, StringType>(d.color.value);
    }
    return map;
  }

  @override
  $TagsMoorTable createAlias(String alias) {
    return $TagsMoorTable(_db, alias);
  }
}

class TemplatesMoorData extends DataClass
    implements Insertable<TemplatesMoorData> {
  final String id;
  final String name;
  final String fields;
  TemplatesMoorData(
      {@required this.id, @required this.name, @required this.fields});
  factory TemplatesMoorData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return TemplatesMoorData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      fields:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}fields']),
    );
  }
  factory TemplatesMoorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TemplatesMoorData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      fields: serializer.fromJson<String>(json['fields']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'fields': serializer.toJson<String>(fields),
    };
  }

  @override
  TemplatesMoorCompanion createCompanion(bool nullToAbsent) {
    return TemplatesMoorCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      fields:
          fields == null && nullToAbsent ? const Value.absent() : Value(fields),
    );
  }

  TemplatesMoorData copyWith({String id, String name, String fields}) =>
      TemplatesMoorData(
        id: id ?? this.id,
        name: name ?? this.name,
        fields: fields ?? this.fields,
      );
  @override
  String toString() {
    return (StringBuffer('TemplatesMoorData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('fields: $fields')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, fields.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TemplatesMoorData &&
          other.id == this.id &&
          other.name == this.name &&
          other.fields == this.fields);
}

class TemplatesMoorCompanion extends UpdateCompanion<TemplatesMoorData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> fields;
  const TemplatesMoorCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.fields = const Value.absent(),
  });
  TemplatesMoorCompanion.insert({
    @required String id,
    this.name = const Value.absent(),
    this.fields = const Value.absent(),
  }) : id = Value(id);
  TemplatesMoorCompanion copyWith(
      {Value<String> id, Value<String> name, Value<String> fields}) {
    return TemplatesMoorCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      fields: fields ?? this.fields,
    );
  }
}

class $TemplatesMoorTable extends TemplatesMoor
    with TableInfo<$TemplatesMoorTable, TemplatesMoorData> {
  final GeneratedDatabase _db;
  final String _alias;
  $TemplatesMoorTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        defaultValue: Constant(""));
  }

  final VerificationMeta _fieldsMeta = const VerificationMeta('fields');
  GeneratedTextColumn _fields;
  @override
  GeneratedTextColumn get fields => _fields ??= _constructFields();
  GeneratedTextColumn _constructFields() {
    return GeneratedTextColumn('fields', $tableName, false,
        defaultValue: Constant(""));
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, fields];
  @override
  $TemplatesMoorTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'templates_moor';
  @override
  final String actualTableName = 'templates_moor';
  @override
  VerificationContext validateIntegrity(TemplatesMoorCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    }
    if (d.fields.present) {
      context.handle(
          _fieldsMeta, fields.isAcceptableValue(d.fields.value, _fieldsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemplatesMoorData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TemplatesMoorData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TemplatesMoorCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.fields.present) {
      map['fields'] = Variable<String, StringType>(d.fields.value);
    }
    return map;
  }

  @override
  $TemplatesMoorTable createAlias(String alias) {
    return $TemplatesMoorTable(_db, alias);
  }
}

abstract class _$MoorAppDatabase extends GeneratedDatabase {
  _$MoorAppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $BucketsMoorTable _bucketsMoor;
  $BucketsMoorTable get bucketsMoor => _bucketsMoor ??= $BucketsMoorTable(this);
  $ContactsMoorTable _contactsMoor;
  $ContactsMoorTable get contactsMoor =>
      _contactsMoor ??= $ContactsMoorTable(this);
  $FieldsMoorTable _fieldsMoor;
  $FieldsMoorTable get fieldsMoor => _fieldsMoor ??= $FieldsMoorTable(this);
  $ReceiptsMoorTable _receiptsMoor;
  $ReceiptsMoorTable get receiptsMoor =>
      _receiptsMoor ??= $ReceiptsMoorTable(this);
  $TagsMoorTable _tagsMoor;
  $TagsMoorTable get tagsMoor => _tagsMoor ??= $TagsMoorTable(this);
  $TemplatesMoorTable _templatesMoor;
  $TemplatesMoorTable get templatesMoor =>
      _templatesMoor ??= $TemplatesMoorTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        bucketsMoor,
        contactsMoor,
        fieldsMoor,
        receiptsMoor,
        tagsMoor,
        templatesMoor
      ];
}
