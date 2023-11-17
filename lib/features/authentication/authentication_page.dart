import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jdl/core/widgets/loading_overlay.dart';
import 'package:jdl/core/widgets/status_message.dart';
import 'package:jdl/features/authentication/authentication_provider.dart';
import 'package:jdl/features/authentication/authentication_service.dart';
import 'package:jdl/features/authentication/models/group/group.dart';

class AuthenticationPage extends ConsumerStatefulWidget {
  const AuthenticationPage({super.key});

  @override
  ConsumerState<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends ConsumerState<AuthenticationPage> {
  final TextEditingController _codeController = TextEditingController();

  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/backgrounds/plantsdark.png"), alignment: Alignment.bottomCenter)),
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Center(
              child: Text(
                "Les jeux de s<3irées",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            )),
            if (_errorMessage.isNotEmpty) ...[
              StatusMessage(
                message: _errorMessage,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Rejoindre un groupe",
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: TextField(
                          controller: _codeController,
                          decoration: const InputDecoration(labelText: "Code du groupe", hintText: "XXXXXX"),
                        )),
                        const SizedBox(
                          width: 4,
                        ),
                        FilledButton(onPressed: () => _onConnect(_codeController.text), child: const Icon(Icons.arrow_forward))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () => _onConnect("PUBLIC"), child: const Text("Rejoindre le groupe publique")),
            Expanded(child: Container()),
          ],
        ),
      ),
    ));
  }

  Future<void> _onConnect(String groupCode) async {
    setState(() {
      _errorMessage = "";
      LoadingOverlay.of(context).show();
    });

    try {
      final Group loggedGroup = await AuthenticationService.instance.getGroupFromCode(groupCode);

      ref.read(authenticationProvider.notifier).login(loggedGroup);

      if (mounted) {
        LoadingOverlay.of(context).hide();
      }
    } on Exception {
      setState(() {
        _errorMessage = "Impossible de rejoindre le groupe. Vérifier le code";
        LoadingOverlay.of(context).hide();
      });
    }
  }
}
