import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jdl/features/authentication/models/group/group.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authenticationProvider = StateNotifierProvider<AuthenticationNotifier, Group?>((ref) {
  return AuthenticationNotifier(null);
});

class AuthenticationNotifier extends StateNotifier<Group?> {
  AuthenticationNotifier(super._state);

  Future<void> initialGroup() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey("group")) {
      final Group localGroup = Group.fromJson(jsonDecode(preferences.getString("group")!) as Map<String, dynamic>);

      state = localGroup;
    }
  }

  Future<void> login(Group group) async {
    state = group;

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("group", jsonEncode(group.toJson()));
  }

  Future<void> logout() async {
    state = null;

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("group");
  }
}
