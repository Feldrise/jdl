import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jdl/core/utils.dart';
import 'package:jdl/core/widgets/loading_overlay.dart';
import 'package:jdl/features/games/game_cards_page/dialogs/add_update_card.dart';
import 'package:jdl/features/games/game_cards_page/widgets/game_mode_button.dart';
import 'package:jdl/features/games/models/game_card/game_card.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GameCardCard extends ConsumerStatefulWidget {
  const GameCardCard({super.key, required this.card, required this.gameID, required this.index});

  final GameCard card;

  final int gameID;
  final int index;

  @override
  ConsumerState<GameCardCard> createState() => _GameCardCardState();
}

class _GameCardCardState extends ConsumerState<GameCardCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        // elevation: 0,
        color: kModuloBackgroundColor(context, widget.index, padding: 1),
        surfaceTintColor: kModuloBackgroundColor(context, widget.index, padding: 1),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () => _onUpdateGameCard(widget.card),
                            color: kModuloTextContainerColor(context, widget.index, padding: 1),
                            icon: const Icon(LucideIcons.edit)),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              widget.card.content,
                              style: TextStyle(color: kModuloTextContainerColor(context, widget.index, padding: 1)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Inclue dans les modes de jeu :",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kModuloTextContainerColor(context, widget.index, padding: 1)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        GameModeButton(color: kModuloTextContainerColor(context, widget.index, padding: 1), mode: "Tous"),
                        InkWell(
                            onTap: () {},
                            child: Icon(
                              LucideIcons.plusCircle,
                              color: kModuloTextContainerColor(context, widget.index, padding: 1),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Image.asset(
                kModuloImage(widget.index, padding: 3),
                width: 64,
                alignment: Alignment.bottomRight,
              ),
            ],
          ),
        ));
  }

  Future<void> _onUpdateGameCard(GameCard initialCard) async {
    bool hasGameAdded = await showModalBottomSheet<bool?>(
            context: context,
            builder: (context) => LoadingOverlay(
                    child: AddUpdateGameCardDialog(
                  gameID: widget.gameID,
                  initialGameCard: initialCard,
                ))) ??
        false;

    if (hasGameAdded) {
      setState(() {});
    }
  }
}
