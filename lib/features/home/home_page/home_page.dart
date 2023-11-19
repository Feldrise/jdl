import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masoiree/core/widgets/backgrounded_button.dart';
import 'package:masoiree/features/authentication/authentication_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/backgrounds/plantdark.png"), alignment: Alignment.bottomCenter)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Quitter le groupe"),
                    onPressed: () {
                      ref.read(authenticationProvider.notifier).logout();
                    },
                  ),
                ),
                Expanded(child: Container()),
                BackgroundedButton(
                    image: "assets/images/party1.png",
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    onPressed: () => context.go("/games"),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 40),
                      child: Text(
                        "Mes jeux",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Theme.of(context).colorScheme.onTertiaryContainer),
                      ),
                    )),
                const SizedBox(
                  height: 12,
                ),
                BackgroundedButton(
                    image: "assets/images/party2.png",
                    color: Theme.of(context).colorScheme.primaryContainer,
                    onPressed: () => context.go("/play"),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 40),
                      child: Text(
                        "Lancer une partie",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                      ),
                    )),
                Expanded(child: Container()),
              ]),
            ),
          )),
    );
  }
}
