import 'package:deadliney/db/database.dart';
import 'package:deadliney/provider/provider.dart';
import 'package:deadliney/shared/shared.dart';
import 'package:deadliney/widgets/tasks/new_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart' hide Column;

/// Function which is used for calling NewTaskDialog
Future<bool?> showNewTaskDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button/
    builder: (BuildContext context) {
      return NewTaskDialog();
    },
  );
}

class NewTaskDialog extends StatefulWidget {
  const NewTaskDialog({Key? key}) : super(key: key);

  @override
  _NewTaskDialogState createState() => _NewTaskDialogState();
}

class _NewTaskDialogState extends State<NewTaskDialog> {
  DateTime _timestamp = currentDateTime();
  DateTime _toDate = currentDateTime();
  DateTime _fromDate = currentDateTime();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  String? _tagDescription;

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      clipBehavior: Clip.antiAlias,
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Add A New Task',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TagScreen()));
                  },
                  icon: Icon(Icons.tag),
                  highlightColor: Colors.white,
                  color: Colors.redAccent,
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        print(value.toString().length);
                      },
                    ),
                    _startDeadlineContainer(),
                    _endDeadlineContainer(),
                    Consumer(
                      builder: (context, watch, _) {
                        final lastTag = watch(lastTagStreamProvider);
                        return lastTag.when(
                          data: (tag) {
                            _tagDescription = tag.description;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(tag.description),
                            );
                          },
                          loading: () => Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (error, stack) => Center(
                            child: Text('$error'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              var taskCompanion = TasksCompanion(
                name: Value(_nameController.text),
                startDate: Value(_fromDate),
                dueDate: Value(_toDate),
                timestamp: Value(_timestamp),
                tag: Value(_tagDescription),
              );
              print(taskCompanion);
              // await context.read(databaseProvider).addTask(taskCompanion);
              // await context.read(boxProvider).put('has_changes', true);

              // _formKey.currentState!.reset();

              // Navigator.of(context).pop(true);
            }
          },
          child: Text(
            'Done',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  ///* start deadline container widget
  Container _startDeadlineContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'From',
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            DateFormat('dd/MM/yy HH:mm').format(_fromDate),
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () async {
              //* Display the time
              DateTime? _pickedDate;
              TimeOfDay? _pickedTime;
              _pickedDate ??= await selectFreeDate(context, _fromDate);
              _pickedTime ??=
                  await selectTime(context, TimeOfDay.fromDateTime(_fromDate));

              var _newDateTime = makeNewDateTime(_pickedDate, _pickedTime);

              var _now = currentDateTime();
              if (_newDateTime.compareTo(_now) >= 0) {
                setState(() {
                  _fromDate = _newDateTime;
                });
              }
            },
            icon: Icon(Icons.edit),
          )
        ],
      ),
    );
  }

  ///* due date / end deadline container widget
  Container _endDeadlineContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'To',
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            DateFormat('dd/MM/yy HH:mm').format(_toDate),
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () async {
              //* Display the time
              DateTime? _pickedDate;
              TimeOfDay? _pickedTime;
              _pickedDate ??= await selectFreeDate(context, _toDate);
              _pickedTime ??=
                  await selectTime(context, TimeOfDay.fromDateTime(_toDate));

              var _newDateTime = makeNewDateTime(_pickedDate, _pickedTime);

              if (_newDateTime.compareTo(_fromDate) >= 0) {
                setState(() {
                  _toDate = _newDateTime;
                });
              }
            },
            icon: Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
