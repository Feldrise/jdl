import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdl/core/widgets/loading_overlay.dart';
import 'package:jdl/features/games/games_page/dialogs/add_game.dart';
import 'package:jdl/features/games/widgets/games_list.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

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
                        context.go("/games/$id");
                      },
                    ))
                  ])))),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddGame,
        child: const Icon(LucideIcons.plus),
      ),
    );
  }

  Future<void> _onAddGame() async {
    bool hasGameAdded = await showModalBottomSheet<bool?>(context: context, builder: (context) => const LoadingOverlay(child: AddGameDialog())) ?? false;

    if (hasGameAdded) {
      setState(() {});
    }
  }
}
