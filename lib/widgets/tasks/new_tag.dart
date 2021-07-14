import 'package:deadliney/db/database.dart';
import 'package:deadliney/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Tag',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                print(value.toString().length);
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var tag = TagsCompanion(
                      description: Value(_descriptionController.text),
                      color: Value(911),
                    );

                    await context.read(databaseProvider).insertTag(tag);
                    await context.read(boxProvider).put('has_changes', true);

                    _formKey.currentState!.reset();

                    Navigator.of(context).pop(true);
                  }
                },
                child: Text('Create tag'))
          ],
        ),
      ),
    );
  }
}
