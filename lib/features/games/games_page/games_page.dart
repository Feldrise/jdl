import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masoiree/core/widgets/loading_overlay.dart';
import 'package:masoiree/features/games/dialogs/game_modes_list.dart';
import 'package:masoiree/features/games/games_page/dialogs/add_game.dart';
import 'package:masoiree/features/games/models/game_mode/game_mode.dart';
import 'package:masoiree/features/games/widgets/games_list.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum GamesPageMode { editing, playing }

class GamesPage extends StatefulWidget {
  const GamesPage({super.key, required this.mode});

  final GamesPageMode mode;

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/backgrounds/plantsdark.png"), alignment: Alignment.bottomCenter)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Text(
                      "Tous mes jeux",
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(child: GamesList(
                      onGameClicked: (id) {
                        if (widget.mode == GamesPageMode.playing) {
                          _onPlayGame(id);
                        } else if (widget.mode == GamesPageMode.editing) {
                          context.go("/games/$id");
                        }
                      },
                    ))
                  ])))),
      floatingActionButton: widget.mode == GamesPageMode.editing
          ? FloatingActionButton(
              onPressed: _onAddGame,
              child: const Icon(LucideIcons.plus),
            )
          : null,
    );
  }

  Future<void> _onPlayGame(int id) async {
    final GameMode? selectedMode = await showDialog(
      context: context,
      builder: (context) => GameModeListDialog(
        gameID: id,
        modeToExclude: const [],
        showMaster: true,
      ),
    );

    if (selectedMode == null) {
      return;
    }

    if (mounted) {
      final String modeFilter = selectedMode.id == 0 ? "" : "?mode=${selectedMode.id}";
      context.go("/play/$id/$modeFilter");
    }
  }

  Future<void> _onAddGame() async {
    bool hasGameAdded = await showModalBottomSheet<bool?>(
            context: context,
            isScrollControlled: true,
            builder: (context) => LoadingOverlay(
                    child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const AddGameDialog(),
                ))) ??
        false;

    if (hasGameAdded) {
      setState(() {});
    }
  }
}
