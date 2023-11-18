import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masoiree/core/form_validator.dart';
import 'package:masoiree/core/widgets/loading_overlay.dart';
import 'package:masoiree/core/widgets/status_message.dart';
import 'package:masoiree/features/authentication/authentication_provider.dart';
import 'package:masoiree/features/games/games_service.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AddGameDialog extends ConsumerStatefulWidget {
  const AddGameDialog({super.key});

  @override
  ConsumerState<AddGameDialog> createState() => _AddGameDialogState();
}

class _AddGameDialogState extends ConsumerState<AddGameDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  String _type = "cards";

  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Créer un jeu",
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
            if (_errorMessage.isNotEmpty) ...[
              StatusMessage(
                message: _errorMessage,
              ),
              const SizedBox(
                height: 12,
              ),
            ],
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Le nom du jeu",
                hintText: "Le nom du jeu...",
              ),
              validator: FormValidator.requiredValidator,
            ),
            const SizedBox(
              height: 12,
            ),
            DropdownButtonFormField(
              value: _type,
              items: const [
                DropdownMenuItem(
                  value: "cards",
                  child: Text("Carte"),
                )
              ],
              decoration: const InputDecoration(
                labelText: "Type de jeu",
              ),
              onChanged: (value) {
                setState(() {
                  _type = value ?? "cards";
                });
              },
              validator: FormValidator.requiredValidator,
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(onPressed: _onAddGame, child: const Text("Créer le jeu"))
          ],
        ),
      ),
    );
  }

  Future<void> _onAddGame() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _errorMessage = "";
      LoadingOverlay.of(context).show();
    });

    try {
      await GamesService.instance.create(_nameController.text, _type, groupCode: ref.read(authenticationProvider)!.code);

      if (mounted) {
        LoadingOverlay.of(context).hide();
        Navigator.of(context).pop(true);
      }
    } on Exception {
      setState(() {
        _errorMessage = "Impossible de créer un jeu...";
        LoadingOverlay.of(context).hide();
      });
    }
  }
}
