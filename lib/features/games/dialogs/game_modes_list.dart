import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:masoiree/core/utils.dart';
import 'package:masoiree/core/widgets/status_message.dart';
import 'package:masoiree/features/authentication/authentication_provider.dart';
import 'package:masoiree/features/games/game_modes_service.dart';
import 'package:masoiree/features/games/models/game_mode/game_mode.dart';

class GameModeListDialog extends ConsumerWidget {
  const GameModeListDialog({super.key, required this.gameID, required this.modeToExclude, this.showMaster = false});

  final int gameID;
  final List<int> modeToExclude;

  final bool showMaster;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
        child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Choisissez une catégorie",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.x),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Flexible(
              child: FutureBuilder(
                future: GameModesService.instance.getAll(gameID, groupCode: ref.watch(authenticationProvider)!.code),
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
                        message: "Impossible de charger les catégories du jeu...",
                      ),
                    );
                  }

                  final List<GameMode> gameModes = snapshot.data!;

                  if (!showMaster && gameModes.isEmpty) {
                    return const Align(
                      alignment: Alignment.topCenter,
                      child: StatusMessage(
                        message: "Vous n'avez pas encore de catégories ! \"+\"",
                        type: StatusMessageType.info,
                      ),
                    );
                  }

                  return ListView(shrinkWrap: true, children: [
                    if (showMaster) ...[
                      InkWell(
                        onTap: () => Navigator.of(context).pop(const GameMode(0, name: "")),
                        child: Card(
                          color: Theme.of(context).colorScheme.primary,
                          surfaceTintColor: Theme.of(context).colorScheme.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text(
                                      "Mélanger toutes les catégories",
                                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Image.asset(
                                  "assets/images/human2.png",
                                  width: 48,
                                  alignment: Alignment.bottomRight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                    for (int index = 0; index < gameModes.length; ++index)
                      if (!modeToExclude.contains(gameModes[index].id)) ...[
                        InkWell(
                          onTap: () => Navigator.of(context).pop(gameModes[index]),
                          child: Card(
                            color: kModuloBackgroundColor(context, index, padding: 2),
                            surfaceTintColor: kModuloBackgroundColor(context, index, padding: 2),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Text(
                                        gameModes[index].name,
                                        style: TextStyle(color: kModuloTextContainerColor(context, index, padding: 2)),
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
                            ),
                          ),
                        ),
                      ]
                  ]);
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
