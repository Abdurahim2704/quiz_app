import 'package:ibrat_informatika/data/models/course.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

sealed class LocalDataService {
  static Future<Course> getCourse() async {
    String filePath = 'assets/datas/data.json';
    final jsonString = await rootBundle.loadString(filePath);

    Map<String, dynamic> jsonData = json.decode(jsonString);
    return Course.fromJson(jsonData);
  }
}
