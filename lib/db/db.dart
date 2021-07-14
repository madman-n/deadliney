import 'dart:io';

import 'package:deadliney/model/model.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import './table.dart';

part 'db.g.dart';

///* Combined two tables for request
class TaskWithTag {
  final Task task;
  final Tag tag;

  TaskWithTag({required this.task, required this.tag});
}

///* DATABASE OPEN ///* DATABASE OPEN ///* DATABASE OPEN ///* DATABASE OPEN ///* DATABASE OPEN
///* DATABASE OPEN ///* DATABASE OPEN ///* DATABASE OPEN ///* DATABASE OPEN ///* DATABASE OPEN
///* DATABASE OPEN ///* DATABASE OPEN ///* DATABASE OPEN ///* DATABASE OPEN ///* DATABASE OPEN
LazyDatabase _openConn() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final filePath = File(p.join(dbFolder.path, 'deadliney.sqlite'));
    return VmDatabase(
      filePath,
      logStatements: true,
    );
  });
}

// this annotation tells moor to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.

@UseMoor(tables: [Tasks, Tags])
class MoorDB extends _$MoorDB {
  MoorDB() : super(_openConn());

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          print('onUpgrade: $migrator');
        },
        beforeOpen: (OpeningDetails details) async {
          if (details.wasCreated) {
            print('Open: ${details.wasCreated}');
          }
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  @override
  int get schemaVersion => 1;

  ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK
  ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK
  ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK ///* CRUD TASK
  // Add , Update, Delete
  Future<int> addTask(TasksCompanion task) => into(tasks).insert(task);
  Future updateTask(TasksCompanion task) => update(tasks).replace(task);
  Future deleteTask(Task task) => delete(tasks).delete(task);

  // Get method
  Future<List<Task>> get allTasks => (select(tasks)
        ..orderBy([(task) => OrderingTerm(expression: task.timestamp)]))
      .get();

  Stream<List<Task>> watchAllTasks(Order order) {
    var orderingMode =
        (order == Order.descending) ? OrderingMode.desc : OrderingMode.asc;
    return (select(tasks)
          ..orderBy([
            (task) =>
                OrderingTerm(expression: task.timestamp, mode: orderingMode)
          ]))
        .watch();
  }

  Stream<List<Task>> watchAllTasksInDay(DateTime date, Order order) {
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0).toUtc();
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59).toUtc();

    var orderingMode =
        (order == Order.descending) ? OrderingMode.desc : OrderingMode.asc;

    return (select(tasks)
          ..where((e) =>
              e.timestamp.isBiggerOrEqualValue(startOfDay) &
              e.timestamp.isSmallerOrEqualValue(endOfDay))
          ..orderBy([
            (task) =>
                OrderingTerm(expression: task.timestamp, mode: orderingMode)
          ]))
        .watch();
  }

  Stream<List<Task>> watchTasksInTimeInterval(
      DateTime start, DateTime end, Order order) {
    final beginning =
        DateTime(start.year, start.month, start.day, 0, 0).toUtc();
    final ending = DateTime(end.year, end.month, end.day, 23, 59).toUtc();

    final orderingMode =
        (order == Order.descending) ? OrderingMode.desc : OrderingMode.asc;

    return (select(tasks)
          ..where((e) =>
              e.timestamp.isBiggerOrEqualValue(beginning) &
              e.timestamp.isSmallerOrEqualValue(ending))
          ..orderBy([
            (task) =>
                OrderingTerm(expression: task.timestamp, mode: orderingMode)
          ]))
        .watch();
  }

  Future<Task> getLastTask() {
    return (select(tasks)
          ..orderBy([
            (task) => OrderingTerm(
                expression: task.timestamp, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingle();
  }

  Stream<Task> watchLastTask() {
    return (select(tasks)
          ..orderBy([
            (task) => OrderingTerm(
                expression: task.timestamp, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .watchSingle();
  }

  ///* CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG
  ///* CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG
  ///* CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG  CRUD TAG

  Stream<Tag> watchTags() => (select(tags)..limit(1)).watchSingle();
  
  Future<int> insertTag(Insertable<Tag> tag) => into(tags).insert(tag);

  Stream<List<TaskWithTag>> watchAllTasksWithTag(Order order) {
    var orderingMode =
        (order == Order.descending) ? OrderingMode.desc : OrderingMode.asc;

    return (select(tasks)
          ..orderBy(([
            (task) =>
                OrderingTerm(expression: task.timestamp, mode: orderingMode),
            (task) => OrderingTerm(expression: task.name)
          ])))
        .join([
          leftOuterJoin(tags, tags.description.equalsExp(tasks.tag)),
        ])
        .watch()
        .map(
          (rows) => rows.map((row) {
            return TaskWithTag(
              task: row.readTable(tasks),
              tag: row.readTable(tags),
            );
          }).toList(),
        );
  }
}
