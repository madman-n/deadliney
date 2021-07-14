import 'package:moor/moor.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 6, max: 64)();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
  TextColumn get tag => text()
      .nullable()
      .customConstraint('NULL REFERENCES tags(description)')();

  DateTimeColumn get timestamp => dateTime().nullable()();
}

class Tags extends Table {
  TextColumn get description => text()();
  IntColumn get color => integer()();

  @override
  Set<Column> get primaryKey => {description};
}

