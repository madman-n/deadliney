// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String name;
  final DateTime? startDate;
  final DateTime? dueDate;
  final bool completed;
  final String? tag;
  final DateTime? timestamp;
  Task(
      {required this.id,
      required this.name,
      this.startDate,
      this.dueDate,
      required this.completed,
      this.tag,
      this.timestamp});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Task(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      startDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}start_date']),
      dueDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date']),
      completed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}completed'])!,
      tag: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tag']),
      timestamp: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime?>(startDate);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime?>(dueDate);
    }
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<String?>(tag);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<DateTime?>(timestamp);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      name: Value(name),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      completed: Value(completed),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      completed: serializer.fromJson<bool>(json['completed']),
      tag: serializer.fromJson<String?>(json['tag']),
      timestamp: serializer.fromJson<DateTime?>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'completed': serializer.toJson<bool>(completed),
      'tag': serializer.toJson<String?>(tag),
      'timestamp': serializer.toJson<DateTime?>(timestamp),
    };
  }

  Task copyWith(
          {int? id,
          String? name,
          DateTime? startDate,
          DateTime? dueDate,
          bool? completed,
          String? tag,
          DateTime? timestamp}) =>
      Task(
        id: id ?? this.id,
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        dueDate: dueDate ?? this.dueDate,
        completed: completed ?? this.completed,
        tag: tag ?? this.tag,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('completed: $completed, ')
          ..write('tag: $tag, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              startDate.hashCode,
              $mrjc(
                  dueDate.hashCode,
                  $mrjc(completed.hashCode,
                      $mrjc(tag.hashCode, timestamp.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.dueDate == this.dueDate &&
          other.completed == this.completed &&
          other.tag == this.tag &&
          other.timestamp == this.timestamp);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime?> startDate;
  final Value<DateTime?> dueDate;
  final Value<bool> completed;
  final Value<String?> tag;
  final Value<DateTime?> timestamp;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
    this.tag = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.startDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
    this.tag = const Value.absent(),
    this.timestamp = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime?>? startDate,
    Expression<DateTime?>? dueDate,
    Expression<bool>? completed,
    Expression<String?>? tag,
    Expression<DateTime?>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (dueDate != null) 'due_date': dueDate,
      if (completed != null) 'completed': completed,
      if (tag != null) 'tag': tag,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime?>? startDate,
      Value<DateTime?>? dueDate,
      Value<bool>? completed,
      Value<String?>? tag,
      Value<DateTime?>? timestamp}) {
    return TasksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
      tag: tag ?? this.tag,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime?>(startDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime?>(dueDate.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String?>(tag.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime?>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('completed: $completed, ')
          ..write('tag: $tag, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 64),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _startDateMeta = const VerificationMeta('startDate');
  late final GeneratedColumn<DateTime?> startDate = GeneratedColumn<DateTime?>(
      'start_date', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  late final GeneratedColumn<DateTime?> dueDate = GeneratedColumn<DateTime?>(
      'due_date', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  late final GeneratedColumn<bool?> completed = GeneratedColumn<bool?>(
      'completed', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (completed IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  late final GeneratedColumn<String?> tag = GeneratedColumn<String?>(
      'tag', aliasedName, true,
      typeName: 'TEXT',
      requiredDuringInsert: false,
      $customConstraints: 'NULL REFERENCES tags(description)');
  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  late final GeneratedColumn<DateTime?> timestamp = GeneratedColumn<DateTime?>(
      'timestamp', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, startDate, dueDate, completed, tag, timestamp];
  @override
  String get aliasedName => _alias ?? 'tasks';
  @override
  String get actualTableName => 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Task.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String description;
  final int color;
  Tag({required this.description, required this.color});
  factory Tag.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Tag(
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['description'] = Variable<String>(description);
    map['color'] = Variable<int>(color);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      description: Value(description),
      color: Value(color),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tag(
      description: serializer.fromJson<String>(json['description']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'description': serializer.toJson<String>(description),
      'color': serializer.toJson<int>(color),
    };
  }

  Tag copyWith({String? description, int? color}) => Tag(
        description: description ?? this.description,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('description: $description, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(description.hashCode, color.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.description == this.description &&
          other.color == this.color);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> description;
  final Value<int> color;
  const TagsCompanion({
    this.description = const Value.absent(),
    this.color = const Value.absent(),
  });
  TagsCompanion.insert({
    required String description,
    required int color,
  })  : description = Value(description),
        color = Value(color);
  static Insertable<Tag> custom({
    Expression<String>? description,
    Expression<int>? color,
  }) {
    return RawValuesInsertable({
      if (description != null) 'description': description,
      if (color != null) 'color': color,
    });
  }

  TagsCompanion copyWith({Value<String>? description, Value<int>? color}) {
    return TagsCompanion(
      description: description ?? this.description,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('description: $description, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  late final GeneratedColumn<int?> color = GeneratedColumn<int?>(
      'color', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [description, color];
  @override
  String get aliasedName => _alias ?? 'tags';
  @override
  String get actualTableName => 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {description};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Tag.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

abstract class _$MoorDB extends GeneratedDatabase {
  _$MoorDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TagsTable tags = $TagsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, tags];
}
