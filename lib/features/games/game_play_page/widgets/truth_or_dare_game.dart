import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masoiree/core/utils.dart';
import 'package:masoiree/core/widgets/status_message.dart';
import 'package:masoiree/features/authentication/authentication_provider.dart';
import 'package:masoiree/features/games/game_cards_service.dart';
import 'package:masoiree/features/games/game_play_page/widgets/arrow.dart';
import 'package:masoiree/features/games/models/game_card/game_card.dart';
import 'package:masoiree/features/games/models/truth_or_dare_cards/truth_or_dare_cards.dart';
import 'package:roulette/roulette.dart';

enum TruthOrDareGameState { chossing, displayingTruth, displayingDare }

class TruthOrDareGame extends ConsumerStatefulWidget {
  const TruthOrDareGame({super.key, required this.gameID, this.modeID, required this.onHasFinished});

  final int gameID;
  final int? modeID;

  final Function() onHasFinished;

  @override
  ConsumerState<TruthOrDareGame> createState() => _TruthOrDareGameState();
}

class _TruthOrDareGameState extends ConsumerState<TruthOrDareGame> with SingleTickerProviderStateMixin {
  List<GameCard>? _truthCards;
  List<GameCard>? _dareCards;

  final CardSwiperController _swiperController = CardSwiperController();
  RouletteController? _rouletteController;

  TruthOrDareGameState _currentState = TruthOrDareGameState.chossing;

  String _errorMessage = "";
  bool _rollingRoulette = false;

  Future<void> _loadGame() async {
    try {
      final TruthOrDareCards cards =
          await GameCardsService.instance.getTruthOrDare(widget.gameID, modeID: widget.modeID, groupCode: ref.read(authenticationProvider)!.code);

      setState(() {
        _errorMessage = "";
        _truthCards = [];
        _dareCards = [];

        _truthCards!.addAll(cards.truth);
        _dareCards!.addAll(cards.dare);
      });
    } on Exception {
      setState(() {
        _errorMessage = "Impossible de charger le jeu...";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _loadGame();
  }

  @override
  void didUpdateWidget(covariant TruthOrDareGame oldWidget) {
    super.didUpdateWidget(oldWidget);

    _loadGame();
  }

  @override
  Widget build(BuildContext context) {
    if (_rouletteController == null) {
      List<String> types = ["truth", "date", "truth", "date", "truth", "dare", "truth", "dare"];

      _rouletteController = RouletteController(
        vsync: this,
        group: RouletteGroup.uniform(
          types.length,
          colorBuilder: (index) => types[index] == "truth" ? Theme.of(context).colorScheme.tertiaryContainer : Theme.of(context).colorScheme.primaryContainer,
          textBuilder: (index) => types[index] == "truth" ? "Vérité" : "Action",
          textStyleBuilder: (index) =>
              TextStyle(color: types[index] == "truth" ? Theme.of(context).colorScheme.onTertiaryContainer : Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      );
    }
    if (_truthCards == null || _dareCards == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return StatusMessage(
        message: _errorMessage,
      );
    }

    if (_truthCards!.isEmpty || _dareCards!.isEmpty) {
      return const Center(
        child: StatusMessage(
          message: "Vous n'avez pas assez de cartes créées pour jouer.",
          type: StatusMessageType.info,
        ),
      );
    }

    if (_currentState == TruthOrDareGameState.displayingDare || _currentState == TruthOrDareGameState.displayingTruth) {
      final int randomPadding = Random().nextInt(10);
      return CardSwiper(
        controller: _swiperController,
        cardsCount: 2,
        isLoop: false,
        onSwipe: (_, __, ___) {
          setState(() {
            if (_currentState == TruthOrDareGameState.displayingTruth) {
              _truthCards!.removeAt(0);
            } else {
              _dareCards!.removeAt(0);
            }

            _rollingRoulette = false;
            _currentState = TruthOrDareGameState.chossing;
          });

          if (_truthCards!.isEmpty || _dareCards!.isEmpty) {
            widget.onHasFinished();
          }

          return true;
        },
        cardBuilder: (context, index, horizontalOffsetPercentage, verticalOffsetPercentage) {
          if (index == 1) {
            return Container();
          }

          return Card(
            color: _currentState == TruthOrDareGameState.displayingTruth
                ? Theme.of(context).colorScheme.tertiaryContainer
                : Theme.of(context).colorScheme.primaryContainer,
            surfaceTintColor: _currentState == TruthOrDareGameState.displayingTruth
                ? Theme.of(context).colorScheme.tertiaryContainer
                : Theme.of(context).colorScheme.primaryContainer,
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
                      child: Text(_currentState == TruthOrDareGameState.displayingTruth ? _truthCards![0].content : _dareCards![0].content,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _currentState == TruthOrDareGameState.displayingTruth
                                ? Theme.of(context).colorScheme.onTertiaryContainer
                                : Theme.of(context).colorScheme.onPrimaryContainer,
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
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: 260,
              height: 260,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Roulette(
                  // Provide controller to update its state
                  controller: _rouletteController!,
                  // Configure roulette's appearance
                  style: const RouletteStyle(
                    dividerThickness: 0.0,
                    dividerColor: Colors.black,
                    centerStickSizePercent: 0.05,
                    centerStickerColor: Colors.black,
                  ),
                ),
              ),
            ),
            const Arrow(),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(onPressed: _rollingRoulette ? null : _onChooseRandomOption, child: const Text("Laisser la roulette choisir")),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
                onPressed: _rollingRoulette
                    ? null
                    : () {
                        setState(() {
                          _currentState = TruthOrDareGameState.displayingDare;
                        });
                      },
                child: const Text("Action"),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
                onPressed: _rollingRoulette
                    ? null
                    : () {
                        setState(() {
                          _currentState = TruthOrDareGameState.displayingTruth;
                        });
                      },
                child: const Text("Vérité"),
              ),
            )
          ],
        )
      ],
    );
  }

  Future<void> _onChooseRandomOption() async {
    final choosedOption = 1 + Random().nextInt(2);
    final offset = Random().nextDouble();

    setState(() {
      _rollingRoulette = true;
    });
    // Spin with offset
    await _rouletteController!.rollTo(choosedOption, offset: offset);
    await Future.delayed(const Duration(milliseconds: 400));

    if (choosedOption == 1) {
      setState(() {
        _currentState = TruthOrDareGameState.displayingDare;
      });
    } else if (choosedOption == 2) {
      setState(() {
        _currentState = TruthOrDareGameState.displayingTruth;
      });
    }
  }
}
