import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jdl/core/utils.dart';
import 'package:jdl/core/widgets/status_message.dart';
import 'package:jdl/features/authentication/authentication_provider.dart';
import 'package:jdl/features/games/game_cards_service.dart';
import 'package:jdl/features/games/games_service.dart';
import 'package:jdl/features/games/models/game_card/game_card.dart';

class GamePlayPage extends ConsumerStatefulWidget {
  const GamePlayPage({super.key, required this.gameID});

  final int gameID;

  @override
  ConsumerState<GamePlayPage> createState() => _GamePlayPageState();
}

class _GamePlayPageState extends ConsumerState<GamePlayPage> {
  final CardSwiperController _swiperController = CardSwiperController();

  bool _hasFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/backgrounds/plantsdark.png"), alignment: Alignment.bottomCenter)),
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
                                  future: GameCardsService.instance.getRandom(widget.gameID, groupCode: ref.watch(authenticationProvider)!.code),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    if (snapshot.hasError) {
                                      return const Center(
                                        child: StatusMessage(
                                          message: "Une erreur s'est produite...",
                                        ),
                                      );
                                    }

                                    final List<GameCard> cards = snapshot.data!;

                                    if (cards.length <= 1) {
                                      return const Center(
                                        child: StatusMessage(
                                          message: "Il n'y a pas encore assez de carte dans ce jeu...",
                                          type: StatusMessageType.info,
                                        ),
                                      );
                                    }

                                    final int randomPadding = Random().nextInt(10);
                                    return CardSwiper(
                                      controller: _swiperController,
                                      cardsCount: cards.length,
                                      isLoop: false,
                                      onEnd: () {
                                        setState(() {
                                          _hasFinished = true;
                                        });
                                      },
                                      cardBuilder: (context, index, horizontalOffsetPercentage, verticalOffsetPercentage) {
                                        return Card(
                                          color: kModuloBackgroundColor(context, index, padding: randomPadding),
                                          surfaceTintColor: kModuloBackgroundColor(context, index, padding: randomPadding),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Center(
                                                  child: Image.asset(
                                                    kModuloImage(index, padding: randomPadding),
                                                    height: 92,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(cards[index].content,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: kModuloTextContainerColor(context, index, padding: randomPadding),
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      _swiperController.swipe();
                                                    },
                                                    child: const Text("Suivant"))
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                        ),
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
