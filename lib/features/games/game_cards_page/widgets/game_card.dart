import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masoiree/core/utils.dart';
import 'package:masoiree/core/widgets/loading_overlay.dart';
import 'package:masoiree/core/widgets/status_message.dart';
import 'package:masoiree/features/authentication/authentication_provider.dart';
import 'package:masoiree/features/games/dialogs/game_modes_list.dart';
import 'package:masoiree/features/games/game_cards_page/dialogs/add_update_card.dart';
import 'package:masoiree/features/games/game_cards_page/widgets/game_mode_button.dart';
import 'package:masoiree/features/games/game_cards_service.dart';
import 'package:masoiree/features/games/models/game_card/game_card.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:masoiree/features/games/models/game_mode/game_mode.dart';

class GameCardCard extends ConsumerStatefulWidget {
  const GameCardCard({super.key, required this.card, required this.onUpdated, required this.gameID, required this.index});

  final GameCard card;

  final Function() onUpdated;

  final int gameID;
  final int index;

  @override
  ConsumerState<GameCardCard> createState() => _GameCardCardState();
}

class _GameCardCardState extends ConsumerState<GameCardCard> {
  final List<GameMode> _gameModes = [];

  String _errorMessage = "";

  @override
  void initState() {
    super.initState();

    _gameModes.clear();
    _gameModes.addAll(widget.card.modes);
  }

  @override
  void didUpdateWidget(covariant GameCardCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    _gameModes.clear();
    _gameModes.addAll(widget.card.modes);
  }

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
                        GameModeButton(color: kModuloTextContainerColor(context, widget.index, padding: 1), mode: "Tout"),
                        for (final mode in _gameModes)
                          GameModeButton(
                              color: kModuloTextContainerColor(context, widget.index, padding: 1), mode: mode.name, onRemove: () => _onRemoveGameMode(mode)),
                        InkWell(
                            onTap: _onAddGameMode,
                            child: Icon(
                              LucideIcons.plusCircle,
                              color: kModuloTextContainerColor(context, widget.index, padding: 1),
                            ))
                      ],
                    ),
                    if (_errorMessage.isNotEmpty) ...[
                      const SizedBox(
                        height: 12,
                      ),
                      StatusMessage(
                        message: _errorMessage,
                      )
                    ]
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
            isScrollControlled: true,
            builder: (context) => LoadingOverlay(
                    child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddUpdateGameCardDialog(
                    gameID: widget.gameID,
                    initialGameCard: initialCard,
                  ),
                ))) ??
        false;

    if (hasGameAdded) {
      widget.onUpdated();
    }
  }

  Future<void> _onAddGameMode() async {
    final GameMode? selectedMode = await showDialog(
      context: context,
      builder: (context) => GameModeListDialog(gameID: widget.gameID, modeToExclude: [for (final mode in _gameModes) mode.id]),
    );

    if (selectedMode == null) {
      return;
    }

    if (mounted) {
      LoadingOverlay.of(context).show();
    }

    try {
      await GameCardsService.instance
          .updateModeAssociation(widget.card.id, selectedMode.id, "add", widget.gameID, groupCode: ref.read(authenticationProvider)!.code);

      setState(() {
        _gameModes.add(selectedMode);
        LoadingOverlay.of(context).hide();
      });
    } on Exception {
      setState(() {
        _errorMessage = "Impossible d'ajouter ce mode...";
        LoadingOverlay.of(context).hide();
      });
    }
  }

  Future<void> _onRemoveGameMode(GameMode toRemove) async {
    LoadingOverlay.of(context).show();

    try {
      await GameCardsService.instance
          .updateModeAssociation(widget.card.id, toRemove.id, "remove", widget.gameID, groupCode: ref.read(authenticationProvider)!.code);

      setState(() {
        _gameModes.remove(toRemove);
        LoadingOverlay.of(context).hide();
      });
    } on Exception {
      setState(() {
        _errorMessage = "Impossible de supprimer ce mode...";
        LoadingOverlay.of(context).hide();
      });
    }
  }
}
