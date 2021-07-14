import 'package:deadliney/db/database.dart';
import 'package:deadliney/model/model.dart';
import 'package:deadliney/provider/provider.dart';
import 'package:deadliney/shared/datetime_method.dart';
import 'package:deadliney/styles/text.dart';
import 'package:deadliney/widgets/progress_bar.dart';
import 'package:deadliney/widgets/tasks/no_tasks_message.dart';
import 'package:deadliney/widgets/tasks/parameter_name_value_pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatelessWidget {
  HistoryView({Key? key}) : super(key: key);
  DateTime _now = currentDateTime();

  @override
  Widget build(BuildContext context) {
    print(_now);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Consumer(
                  builder: (context, watch, _) {
                    return DropdownButton<Order>(
                      value: watch(orderingProvider).state,
                      items: Order.values
                          .map<DropdownMenuItem<Order>>(
                            (option) => DropdownMenuItem(
                              value: option,
                              child: Text(orderingInStringFormat(option)),
                            ),
                          )
                          .toList(),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(),
                      style: dropdownButtonTextStyle,
                      onChanged: (Order? newValue) {
                        context.read(orderingProvider).state = newValue!;
                      },
                    );
                  },
                ),
                Consumer(
                  builder: (context, watch, _) {
                    return DropdownButton<TimeInterval>(
                      value: watch(timeIntervalProvider).state,
                      items: TimeInterval.values
                          .map<DropdownMenuItem<TimeInterval>>(
                            (option) => DropdownMenuItem(
                              value: option,
                              child: Text(timeIntervalInStringFormat(option)),
                            ),
                          )
                          .toList(),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (TimeInterval? newValue) {
                        context.read(timeIntervalProvider).state = newValue!;
                      },
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: Consumer(
                builder: (context, watch, _) {
                  var list = watch(listOfTasksProvider);
                  return list.when(
                      data: (List<Task> value) {
                        if (value.isEmpty) {
                          return Center(
                            child: NoTasksMessage(),
                          );
                        }
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return SizedBox(
                                  height: 10.0,
                                );
                              }

                              final task = value[index - 1];
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                child: Dismissible(
                                  key: Key(task.id.toString()),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 32.0,
                                          ),
                                          Text(
                                            'DELETE',
                                            style: entryCardTextStyle.copyWith(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onDismissed: (direction) async {
                                    await context
                                        .read(databaseProvider)
                                        .deleteTask(task);
                                    await context
                                        .read(boxProvider)
                                        .put('has_changed', true);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ParameterNameValuePair(
                                              name: 'Name ',
                                              value: task.name,
                                              axis: Axis.horizontal,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                ((task.dueDate)!
                                                            .difference(_now))
                                                        .inDays
                                                        .toString() +
                                                    ' Days ' +
                                                    ((task.dueDate!)
                                                                .difference(
                                                                    _now)
                                                                .inHours %
                                                            24)
                                                        .toString() +
                                                    ' Hours Left',
                                              )
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                      Divider(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: Text(
                                          DateFormat('dd.MM.yyyy - HH:mm')
                                              .format(task.timestamp!),
                                          style: entryCardTextStyle,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      Divider(),
                                      AnimatedProgressBar(
                                        value: _progressCalculate(task),
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10.0),
                            itemCount: value.length + 1);
                      },
                      loading: () => const Center(
                            child: const CircularProgressIndicator(),
                          ),
                      error: (error, stack) => Center(
                            child: Text('Error $error'),
                          ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _progressCalculate(Task task) {
    // Day passed
    final dayPassed = (task.dueDate!).difference(_now).inDays;

    final total = (task.dueDate!).difference(task.startDate!).inDays;

    final dayLeft = (task.dueDate!).difference(_now).inHours;
    final mDay = dayLeft ~/ 24;
    final mHour = dayLeft % 24;
    print('$mDay Days $mHour Hours');

    return (dayPassed / total);
  }
}
