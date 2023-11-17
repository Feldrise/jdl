import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jdl/core/constants.dart';
import 'package:jdl/features/authentication/models/group/group.dart';

import 'package:http/http.dart' as http;

class AuthenticationService {
  AuthenticationService._();

  final String serviceBaseURL = "$kApiBaseURL/groups";

  static final AuthenticationService instance = AuthenticationService._();

  Future<Group> getGroupFromCode(String groupCode) async {
    final http.Response response = await http.get(
      Uri.parse("$serviceBaseURL/code/$groupCode"),
    );

    if (response.statusCode == 200) {
      return Group.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }

    throw PlatformException(code: response.statusCode.toString(), message: response.body);
  }
}
