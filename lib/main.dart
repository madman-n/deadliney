import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'view/home_view.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('changes');

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deadliney',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    home: HomeView(),
    );
  }
}
