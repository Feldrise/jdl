import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:masoiree/core/constants.dart';

import 'package:http/http.dart' as http;
import 'package:masoiree/features/games/models/game_card/game_card.dart';
import 'package:masoiree/features/games/models/truth_or_dare_cards/truth_or_dare_cards.dart';

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

  Future<List<GameCard>> getRandom(int gameID, {int limit = 20, int? modeID, required String groupCode}) async {
    final String modeIDFilter = modeID == null ? "" : "&mode=$modeID";
    final http.Response response = await http.get(
      Uri.parse("$kApiBaseURL/games/$gameID/cards/random?limit=$limit$modeIDFilter"),
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

  Future<TruthOrDareCards> getTruthOrDare(int gameID, {int limit = 20, int? modeID, required String groupCode}) async {
    final String modeIDFilter = modeID == null ? "" : "&mode=$modeID";
    final http.Response response = await http.get(
      Uri.parse("$kApiBaseURL/games/$gameID/cards/truthordare?limit=$limit$modeIDFilter"),
      headers: {
        "JDLGroupCode": groupCode,
      },
    );

    if (response.statusCode == 200) {
      return TruthOrDareCards.fromJson(jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }

  Future<void> create(String content, int gameID, {String? type, required String groupCode}) async {
    final http.Response response = await http.post(Uri.parse("$kApiBaseURL/games/$gameID/cards"),
        headers: {
          "JDLGroupCode": groupCode,
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        },
        body: jsonEncode({
          "content": content,
          "type": type,
        }));

    if (response.statusCode != 201) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }

  Future<void> update(int id, String content, int gameID, {String? type, required String groupCode}) async {
    final http.Response response = await http.put(Uri.parse("$kApiBaseURL/games/$gameID/cards/$id"),
        headers: {
          "JDLGroupCode": groupCode,
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        },
        body: jsonEncode({"content": content, "type": type}));

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }

  Future<void> updateModeAssociation(int id, int modeID, String type, int gameID, {required String groupCode}) async {
    final http.Response response = await http.put(Uri.parse("$kApiBaseURL/games/$gameID/cards/$id/modeassociation"),
        headers: {
          "JDLGroupCode": groupCode,
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        },
        body: jsonEncode({"mode_id": modeID, "type": type}));

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }
  }
}
