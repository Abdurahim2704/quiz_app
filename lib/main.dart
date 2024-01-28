import 'package:flutter/material.dart';
import 'package:ibrat_informatika/app.dart';
import 'package:ibrat_informatika/data/services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.open();
  runApp(const MyApp());
}
