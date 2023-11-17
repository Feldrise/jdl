import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:jdl/core/constants.dart';

import 'package:http/http.dart' as http;
import 'package:jdl/features/games/models/game_card/game_card.dart';

class GameCardsService {
  GameCardsService._();

  static final GameCardsService instance = GameCardsService._();

  Future<List<GameCard>> getAll(int gameID, {required String groupCode}) async {
    final http.Response response = await http.get(
      Uri.parse("$kApiBaseURL/games/$gameID/cards"),
      headers: {
        "JDLGroupCode": groupCode,
      },
    );

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> gameCardsMaps = (jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>).cast<Map<String, dynamic>>();
      final List<GameCard> result = [];

      for (final map in gameCardsMaps) {
        result.add(GameCard.fromJson(map));
      }

      return result;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<List<GameCard>> getRandom(int gameID, {int limit = 20, required String groupCode}) async {
    final http.Response response = await http.get(
      Uri.parse("$kApiBaseURL/games/$gameID/cards/random?limit=$limit"),
      headers: {
        "JDLGroupCode": groupCode,
      },
    );

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> gameCardsMaps = (jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>).cast<Map<String, dynamic>>();
      final List<GameCard> result = [];

      for (final map in gameCardsMaps) {
        result.add(GameCard.fromJson(map));
      }

      return result;
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<void> create(String content, int gameID, {required String groupCode}) async {
    final http.Response response = await http.post(Uri.parse("$kApiBaseURL/games/$gameID/cards"),
        headers: {
          "JDLGroupCode": groupCode,
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        },
        body: jsonEncode({
          "content": content,
        }));

    if (response.statusCode != 201) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }

  Future<void> update(int id, String content, int gameID, {required String groupCode}) async {
    final http.Response response = await http.put(Uri.parse("$kApiBaseURL/games/$gameID/cards/$id"),
        headers: {
          "JDLGroupCode": groupCode,
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        },
        body: jsonEncode({
          "content": content,
        }));

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }
}
