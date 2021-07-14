import 'package:flutter/material.dart';

DateTime currentDateTime() {
  return DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
  );
}

DateTime makeNewDateTime(DateTime date, TimeOfDay time) {
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}

//* Week TimeInterval: first day of the Week, last day of the Week
DateTime firstDayOfTheWeek(DateTime date) {
  final startDate = date.subtract(Duration(days: date.weekday - 1));
  final startDateWithTime =
      DateTime(startDate.year, startDate.month, startDate.day);
  return startDateWithTime;
}

DateTime lastDayOfTheWeek(DateTime date) {
  final endDate = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  final endDateWithTime =
      DateTime(endDate.year, endDate.month, endDate.day, 23, 59);
  return endDateWithTime;
}

//* Month TimeInterval: first day of the Month, last day of the Month
DateTime firstDayOfTheMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime lastDayOfTheMonth(DateTime date) {
  final numberOfDaysInMonth = _getNumberOfDaysInMonth(date);
  return DateTime(date.year, date.month, numberOfDaysInMonth, 23, 59);
}

//* Year TimeInterval: first day of the year, last day of the year
DateTime firstDayOfTheYear(DateTime date) {
  return DateTime(date.year, DateTime.january, 1, 0, 0);
}

DateTime lastDayOfTheYear(DateTime date) {
  return DateTime(date.year, DateTime.december, 30, 23, 59);
}

int _getNumberOfDaysInMonth(DateTime date) {
  DateTime firstDayOfNextMonth;
  if (date.month < 12) {
    firstDayOfNextMonth = DateTime(date.year, date.month + 1, 1);
  } else {
    firstDayOfNextMonth = DateTime(date.year + 1, 1, 1);
  }
  DateTime lastDayOfCurrentMonth =
      firstDayOfNextMonth.subtract(Duration(days: 1));
  return lastDayOfCurrentMonth.day;
}

//* Select Date
Future<DateTime> selectDate(BuildContext context, DateTime initialDate) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime.now().subtract(Duration(days: 30)),
    lastDate: DateTime.now(),
    initialEntryMode: DatePickerEntryMode.calendar,
  );
  return pickedDate!;
}

//* Select Time
Future<TimeOfDay> selectTime(
    BuildContext context, TimeOfDay initialTime) async {
  final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.input);
  return pickedTime!;
}

//* Select Date
Future<DateTime> selectFreeDate(
    BuildContext context, DateTime initialDate) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime.now().subtract(Duration(days: 30)),
    initialEntryMode: DatePickerEntryMode.calendar,
    lastDate: DateTime.now().add(Duration(days: 1825)),
  );
  return pickedDate!;
}
