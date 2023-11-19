import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masoiree/core/utils.dart';
import 'package:masoiree/core/widgets/status_message.dart';
import 'package:masoiree/features/authentication/authentication_provider.dart';
import 'package:masoiree/features/games/game_cards_service.dart';
import 'package:masoiree/features/games/models/game_card/game_card.dart';

class ClassicalGame extends ConsumerStatefulWidget {
  const ClassicalGame({super.key, required this.gameID, required this.modeID, required this.onHasFinished});

  final int gameID;
  final int? modeID;

  final Function() onHasFinished;

  @override
  ConsumerState<ClassicalGame> createState() => _ClassicalGameState();
}

class _ClassicalGameState extends ConsumerState<ClassicalGame> {
  final CardSwiperController _swiperController = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GameCardsService.instance.getRandom(widget.gameID, groupCode: ref.watch(authenticationProvider)!.code, modeID: widget.modeID),
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
            widget.onHasFinished();
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
    );
  }
}
