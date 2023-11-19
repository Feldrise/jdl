import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masoiree/core/utils.dart';
import 'package:masoiree/core/widgets/status_message.dart';
import 'package:masoiree/features/authentication/authentication_provider.dart';
import 'package:masoiree/features/games/game_cards_service.dart';
import 'package:masoiree/features/games/game_play_page/widgets/classical_game.dart';
import 'package:masoiree/features/games/game_play_page/widgets/truth_or_dare_game.dart';
import 'package:masoiree/features/games/games_service.dart';
import 'package:masoiree/features/games/models/game/game.dart';
import 'package:masoiree/features/games/models/game_card/game_card.dart';

class GamePlayPage extends ConsumerStatefulWidget {
  const GamePlayPage({super.key, required this.gameID, this.modeID});

  final int gameID;
  final int? modeID;

  @override
  ConsumerState<GamePlayPage> createState() => _GamePlayPageState();
}

class _GamePlayPageState extends ConsumerState<GamePlayPage> {
  bool _hasFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            // decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/backgrounds/plantdark.png"), alignment: Alignment.bottomCenter)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        FutureBuilder(
                          future: GamesService.instance.get(widget.gameID, groupCode: ref.watch(authenticationProvider)!.code),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                              return Text(
                                snapshot.data!.name,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                              );
                            }

                            if (snapshot.hasError) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Container();
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Expanded(
                            child: _hasFinished
                                ? const Center(
                                    child: StatusMessage(
                                      message: "Bravo ! Vous avez fini le jeu ! 🎉",
                                      type: StatusMessageType.info,
                                    ),
                                  )
                                : FutureBuilder(
                                    future: GamesService.instance.get(widget.gameID, groupCode: ref.watch(authenticationProvider)!.code),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (snapshot.hasError) {
                                        return const StatusMessage(
                                          message: "Impossible de charger le jeu...",
                                        );
                                      }

                                      final Game game = snapshot.data!;

                                      if (game.type == "truthordare") {
                                        return TruthOrDareGame(
                                          gameID: widget.gameID,
                                          onHasFinished: () {
                                            setState(() {
                                              _hasFinished = true;
                                            });
                                          },
                                          modeID: widget.modeID,
                                        );
                                      }
                                      return ClassicalGame(
                                          gameID: widget.gameID,
                                          modeID: widget.modeID,
                                          onHasFinished: () {
                                            setState(() {
                                              _hasFinished = true;
                                            });
                                          });
                                    })),
                        const SizedBox(
                          height: 24,
                        ),
                        FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Quitter le jeu")),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    )))));
  }
}
