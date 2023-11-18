import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masoiree/core/utils.dart';
import 'package:masoiree/core/widgets/backgrounded_button.dart';
import 'package:masoiree/core/widgets/status_message.dart';
import 'package:masoiree/features/authentication/authentication_provider.dart';
import 'package:masoiree/features/games/games_service.dart';
import 'package:masoiree/features/games/models/game/game.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GamesList extends ConsumerWidget {
  const GamesList({super.key, required this.onGameClicked});

  final Function(int) onGameClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: GamesService.instance.getAll(groupCode: ref.watch(authenticationProvider)?.code ?? ""),
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
              message: "Impossible de charger vos jeux...",
            ),
          );
        }

        final List<Game> games = snapshot.data!;

        if (games.isEmpty) {
          return const Align(
            alignment: Alignment.topCenter,
            child: StatusMessage(
              message: "Vous n'avez pas encore de jeux ! Créer-en un en appuyant sur le \"+\"",
              type: StatusMessageType.info,
            ),
          );
        }

        return ListView.separated(
            itemBuilder: (context, index) => BackgroundedButton(
                  image: kModuloImage(index),
                  color: kModuloBackgroundColor(context, index),
                  onPressed: () => onGameClicked(games[index].id),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 60, bottom: 20),
                    child: Row(
                      children: [
                        const Icon(LucideIcons.diamond),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            games[index].name,
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kModuloTextContainerColor(context, index)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
            itemCount: games.length);
      },
    );
  }
}
