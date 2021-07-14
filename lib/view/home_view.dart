import 'package:deadliney/db/database.dart';
import 'package:deadliney/provider/provider.dart';

import 'package:deadliney/styles/text.dart';
import 'package:deadliney/view/view.dart';
import 'package:deadliney/widgets/widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Todo',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                elevation: 6.0,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Consumer(builder: (context, watch, _) {
                  var lastTask = watch(lastTaskStreamProvider);
                  return lastTask.when(
                    data: (task) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60.0,
                          ),
                          Text(
                            'Last Task:',
                            style: homeScreenTextStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DateFormat('dd. MMMM. yyyy - HH:mm')
                                  .format(task.timestamp!),
                            ),
                          ),
                          ParameterNameValuePair(
                            name: 'NAME ',
                            value: task.name,
                            axis: Axis.horizontal,
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                        ],
                      );
                    },
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60.0),
                        child: NoTasksMessage(),
                      ),
                    ),
                  );
                }),
              ),
              Builder(
                builder: (context) => HomeButton(
                  text: 'New Task',
                  onPressed: () async {
                    var successfulTask = await showNewTaskDialog(context);
                    if (successfulTask!) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Successfully made new task'),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
              ),
              Builder(
                builder: (context) => HomeButton(
                  text: 'History',
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HistoryView()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
