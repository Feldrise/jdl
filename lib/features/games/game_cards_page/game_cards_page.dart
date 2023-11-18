import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masoiree/core/widgets/backgrounded_button.dart';
import 'package:masoiree/core/widgets/loading_overlay.dart';
import 'package:masoiree/core/widgets/status_message.dart';
import 'package:masoiree/features/authentication/authentication_provider.dart';
import 'package:masoiree/features/games/game_cards_page/dialogs/add_update_card.dart';
import 'package:masoiree/features/games/game_cards_page/widgets/game_card.dart';
import 'package:masoiree/features/games/game_cards_service.dart';
import 'package:masoiree/features/games/games_service.dart';
import 'package:masoiree/features/games/models/game_card/game_card.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GameCardsPage extends ConsumerStatefulWidget {
  const GameCardsPage({super.key, required this.gameID});

  final int gameID;

  @override
  ConsumerState<GameCardsPage> createState() => _GameCardsPageState();
}

class _GameCardsPageState extends ConsumerState<GameCardsPage> {
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
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    BackgroundedButton(
                      image: "assets/images/human1.png",
                      color: Theme.of(context).colorScheme.primaryContainer,
                      onPressed: () {
                        context.go("/games/${widget.gameID}/modes");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, right: 60, bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Les modes de jeu",
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextButton.icon(onPressed: () {}, icon: const Icon(Icons.arrow_back), label: const Text("Voir les modes du jeu")))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Les cartes du jeu",
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: GameCardsService.instance.getAll(widget.gameID, groupCode: ref.watch(authenticationProvider)!.code),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return const Align(
                              alignment: Alignment.topCenter,
                              child: StatusMessage(
                                message: "Impossible de charger les cartes du jeu...",
                              ),
                            );
                          }

                          final List<GameCard> gameCards = snapshot.data!;

                          if (gameCards.isEmpty) {
                            return const Align(
                              alignment: Alignment.topCenter,
                              child: StatusMessage(
                                message: "Vous n'avez pas encore de cartes ! Créer-en un en appuyant sur le \"+\"",
                                type: StatusMessageType.info,
                              ),
                            );
                          }

                          return ListView.separated(
                            itemCount: gameCards.length,
                            itemBuilder: (context, index) => GameCardCard(
                              card: gameCards[index],
                              gameID: widget.gameID,
                              index: index,
                              onUpdated: () {
                                setState(() {});
                              },
                            ),
                            separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            ),
                          );
                        },
                      ),
                    )
                  ])))),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddGameCard,
        child: const Icon(LucideIcons.plus),
      ),
    );
  }

  Future<void> _onAddGameCard() async {
    bool hasGameAdded =
        await showModalBottomSheet<bool?>(context: context, builder: (context) => LoadingOverlay(child: AddUpdateGameCardDialog(gameID: widget.gameID))) ??
            false;

    if (hasGameAdded) {
      setState(() {});
    }
  }
}
