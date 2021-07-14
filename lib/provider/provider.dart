import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:deadliney/model/model.dart';
import 'package:deadliney/shared/shared.dart';
import 'package:deadliney/db/database.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

///* Database Provider
final databaseProvider = Provider<MoorDB>((ref) {
  var database = MoorDB();
  ref.onDispose(() => database.close());
  return database;
});

///* State Provider with Enum
/// Provides currently selected ordering option.
final orderingProvider = StateProvider<Order>((ref) => Order.descending);

/// Provides currently selected time period for showing entries
final timeIntervalProvider =
    StateProvider<TimeInterval>((ref) => TimeInterval.today);

///

final lastTagStreamProvider = StreamProvider<Tag>((ref) {
  var database = ref.watch(databaseProvider);
  return database.watchTags();
});

/// Provides a stream which emits latest database entry by timestamp
final lastTaskStreamProvider = StreamProvider<Task>((ref) {
  var database = ref.watch(databaseProvider);
  return database.watchLastTask();
});

/// Provides Stream of List<Entry> based on values of ordering option and time period
final listOfTasksProvider = StreamProvider<List<Task>>((ref) {
  var database = ref.watch(databaseProvider);
  var timePeriod = ref.watch(timeIntervalProvider).state;
  var order = ref.watch(orderingProvider).state;

  var now = currentDateTime();

  switch (timePeriod) {
    case TimeInterval.today:
      return database.watchAllTasksInDay(now, order);
    case TimeInterval.yesterday:
      return database.watchAllTasksInDay(
          now.subtract(Duration(days: 1)), order);
    case TimeInterval.week:
      return database.watchTasksInTimeInterval(
          firstDayOfTheWeek(now), lastDayOfTheWeek(now), order);
    case TimeInterval.month:
      return database.watchTasksInTimeInterval(
          firstDayOfTheMonth(now), lastDayOfTheMonth(now), order);
    case TimeInterval.year:
      return database.watchTasksInTimeInterval(
          firstDayOfTheYear(now), lastDayOfTheYear(now), order);
    case TimeInterval.alltime:
      return database.watchAllTasks(order);
  }
});

/// Provides Hive's [Box] throughout the application
final boxProvider = Provider<Box<dynamic>>((ref) {
  var box = Hive.box('changes');
  if (!box.containsKey('has_changes')) {
    box.put('has_changes', false);
  }
  ref.onDispose(() async {
    await box.compact();
    await box.close();
  });
  return box;
});

/// Provides ValueListenable<Box<dynamic>> so that we could use it
/// int [ValueListenableBuilder] and react on changes in box.
final listenableProvider = Provider<ValueListenable<Box>>((ref) {
  var box = ref.watch(boxProvider);
  return box.listenable(keys: ['has_changes']);
});
