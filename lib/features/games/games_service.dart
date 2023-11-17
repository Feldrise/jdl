import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:jdl/core/constants.dart';

import 'package:http/http.dart' as http;
import 'package:jdl/features/games/models/game/game.dart';

class GamesService {
  GamesService._();

  final String serviceBaseURL = "$kApiBaseURL/games";

  static final GamesService instance = GamesService._();

  Future<Game> get(int id, {required String groupCode}) async {
    final http.Response response = await http.get(
      Uri.parse("$serviceBaseURL/$id"),
      headers: {
        "JDLGroupCode": groupCode,
      },
    );

    if (response.statusCode == 200) {
      return Game.fromJson(jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<List<Game>> getAll({required String groupCode}) async {
    final http.Response response = await http.get(
      Uri.parse(serviceBaseURL),
      headers: {
        "JDLGroupCode": groupCode,
      },
    );

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> gamesMaps = (jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>).cast<Map<String, dynamic>>();
      final List<Game> result = [];

      for (final map in gamesMaps) {
        result.add(Game.fromJson(map));
      }

      return result;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<void> create(String name, String type, {required String groupCode}) async {
    final http.Response response = await http.post(Uri.parse(serviceBaseURL),
        headers: {
          "JDLGroupCode": groupCode,
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        },
        body: jsonEncode({
          "name": name,
          "type": type,
        }));

    if (response.statusCode != 201) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }
}
