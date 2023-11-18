import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:masoiree/core/constants.dart';

import 'package:http/http.dart' as http;
import 'package:masoiree/features/games/models/game_mode/game_mode.dart';

class GameModesService {
  GameModesService._();

  static final GameModesService instance = GameModesService._();

  Future<List<GameMode>> getAll(int gameID, {required String groupCode}) async {
    final http.Response response = await http.get(
      Uri.parse("$kApiBaseURL/games/$gameID/modes"),
      headers: {
        "JDLGroupCode": groupCode,
      },
    );

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> gameModesMaps = (jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>).cast<Map<String, dynamic>>();
      final List<GameMode> result = [];

      for (final map in gameModesMaps) {
        result.add(GameMode.fromJson(map));
      }

      return result;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<void> create(String name, int gameID, {required String groupCode}) async {
    final http.Response response = await http.post(Uri.parse("$kApiBaseURL/games/$gameID/modes"),
        headers: {
          "JDLGroupCode": groupCode,
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        },
        body: jsonEncode({
          "name": name,
        }));

    if (response.statusCode != 201) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }

  Future<void> update(int id, String name, int gameID, {required String groupCode}) async {
    final http.Response response = await http.put(Uri.parse("$kApiBaseURL/games/$gameID/modes/$id"),
        headers: {
          "JDLGroupCode": groupCode,
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        },
        body: jsonEncode({
          "name": name,
        }));

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }
}
