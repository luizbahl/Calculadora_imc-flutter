import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('imcBox');
  runApp(const MyApp());
}
