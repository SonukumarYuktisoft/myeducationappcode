import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalApiService {
  final Dio dio = Dio();

  Future<List<dynamic>> getLocalJson(String path) async {
    // Local file read
    final data = await rootBundle.loadString(path);
    final jsonResult = jsonDecode(data);
    return jsonResult;
  }
}
