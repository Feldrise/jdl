import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:masoiree/core/utils.dart';
import 'package:masoiree/core/widgets/loading_overlay.dart';
import 'package:masoiree/core/widgets/status_message.dart';
import 'package:masoiree/features/authentication/authentication_provider.dart';
import 'package:masoiree/features/games/game_modes_page/dialogs/add_update_game_mode.dart';
import 'package:masoiree/features/games/game_modes_service.dart';
import 'package:masoiree/features/games/games_service.dart';
import 'package:masoiree/features/games/models/game_mode/game_mode.dart';

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
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Text(
                      "Les modes du jeu",
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: GameModesService.instance.getAll(widget.gameID, groupCode: ref.watch(authenticationProvider)!.code),
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
                                message: "Impossible de charger les modes du jeu...",
                              ),
                            );
                          }

                          final List<GameMode> gameModes = snapshot.data!;

                          if (gameModes.isEmpty) {
                            return const Align(
                              alignment: Alignment.topCenter,
                              child: StatusMessage(
                                message: "Vous n'avez pas encore de modes ! Créer-en un en appuyant sur le \"+\"",
                                type: StatusMessageType.info,
                              ),
                            );
                          }

                          return ListView.separated(
                            itemCount: gameModes.length,
                            itemBuilder: (context, index) => Card(
                              color: kModuloBackgroundColor(context, index, padding: 2),
                              surfaceTintColor: kModuloBackgroundColor(context, index, padding: 2),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () => _onUpdateGameMode(gameModes[index]),
                                              color: kModuloTextContainerColor(context, index, padding: 1),
                                              icon: const Icon(LucideIcons.edit)),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 12),
                                              child: Text(
                                                gameModes[index].name,
                                                style: TextStyle(color: kModuloTextContainerColor(context, index, padding: 1)),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Image.asset(
                                            kModuloImage(index, padding: 5),
                                            width: 48,
                                            alignment: Alignment.bottomRight,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // itemBuilder: (context, index) => GameCardCard(
                            //   card: gameCards[index],
                            //   gameID: widget.gameID,
                            //   index: index,
                            //   onUpdated: () {
                            //     setState(() {});
                            //   },
                            // ),
                            separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            ),
                          );
                        },
                      ),
                    )
                  ])))),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddGameMode,
        child: const Icon(LucideIcons.plus),
      ),
    );
  }

  Future<void> _onUpdateGameMode(GameMode initialMode) async {
    bool hasGameAdded = await showModalBottomSheet<bool?>(
            context: context,
            builder: (context) => LoadingOverlay(
                    child: AddUpdateGameModeDialog(
                  gameID: widget.gameID,
                  initialGameMode: initialMode,
                ))) ??
        false;

    if (hasGameAdded) {
      setState(() {});
    }
  }

  Future<void> _onAddGameMode() async {
    bool hasGameAdded =
        await showModalBottomSheet<bool?>(context: context, builder: (context) => LoadingOverlay(child: AddUpdateGameModeDialog(gameID: widget.gameID))) ??
            false;

    if (hasGameAdded) {
      setState(() {});
    }
  }
}
