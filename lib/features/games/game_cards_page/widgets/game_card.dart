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
  const GameCardCard({super.key, required this.card, required this.onUpdated, required this.gameID, required this.gameType, required this.index});

  final GameCard card;

  final Function() onUpdated;

  final int gameID;
  final String gameType;
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

  Color _getCardBackgroundColor() {
    if (widget.gameType == "truthordare") {
      if (widget.card.type == "truth") {
        return Theme.of(context).colorScheme.tertiaryContainer;
      } else if (widget.card.type == "dare") {
        return Theme.of(context).colorScheme.primaryContainer;
      }
    }

    return kModuloBackgroundColor(context, widget.index, padding: 1);
  }

  Color _getCardTextColor() {
    if (widget.gameType == "truthordare") {
      if (widget.card.type == "truth") {
        return Theme.of(context).colorScheme.onTertiaryContainer;
      } else if (widget.card.type == "dare") {
        return Theme.of(context).colorScheme.onPrimaryContainer;
      }
    }

    return kModuloTextContainerColor(context, widget.index, padding: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        // elevation: 0,
        color: _getCardBackgroundColor(),
        surfaceTintColor: _getCardBackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.gameType == "truthordare") ...[
                      GameModeButton(color: _getCardTextColor(), mode: widget.card.type == "dare" ? "Action" : "Vérité"),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(onPressed: () => _onUpdateGameCard(widget.card), color: _getCardTextColor(), icon: const Icon(LucideIcons.edit)),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              widget.card.content,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: _getCardTextColor()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Inclue dans les catégories du jeu :",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: _getCardTextColor()),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        GameModeButton(color: _getCardTextColor(), mode: "Toutes"),
                        for (final mode in _gameModes) GameModeButton(color: _getCardTextColor(), mode: mode.name, onRemove: () => _onRemoveGameMode(mode)),
                        InkWell(onTap: _onAddGameMode, child: Icon(LucideIcons.plusCircle, color: _getCardTextColor()))
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
                    gameType: widget.gameType,
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
