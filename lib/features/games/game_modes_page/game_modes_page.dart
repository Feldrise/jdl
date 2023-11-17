import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jdl/features/authentication/authentication_provider.dart';
import 'package:jdl/features/games/games_service.dart';

class GameModesPage extends ConsumerStatefulWidget {
  const GameModesPage({super.key, required this.gameID});

  final int gameID;

  @override
  ConsumerState<GameModesPage> createState() => _GameModesPageState();
}

class _GameModesPageState extends ConsumerState<GameModesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FutureBuilder(
            future: GamesService.instance.get(widget.gameID, groupCode: ref.watch(authenticationProvider)!.code),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                return Text(snapshot.data!.name);
              }

              return Container();
            },
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/backgrounds/plantsdark.png"), alignment: Alignment.bottomCenter)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [])))));
  }
}
