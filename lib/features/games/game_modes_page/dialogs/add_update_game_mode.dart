import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:masoiree/core/form_validator.dart';
import 'package:masoiree/core/widgets/loading_overlay.dart';
import 'package:masoiree/core/widgets/status_message.dart';
import 'package:masoiree/features/authentication/authentication_provider.dart';
import 'package:masoiree/features/games/game_modes_service.dart';
import 'package:masoiree/features/games/models/game_mode/game_mode.dart';

class AddUpdateGameModeDialog extends ConsumerStatefulWidget {
  const AddUpdateGameModeDialog({super.key, required this.gameID, this.initialGameMode});

  final GameMode? initialGameMode;
  final int gameID;

  @override
  ConsumerState<AddUpdateGameModeDialog> createState() => _AddUpdateGameModeDialogState();
}

class _AddUpdateGameModeDialogState extends ConsumerState<AddUpdateGameModeDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  String _errorMessage = "";

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.initialGameMode?.name ?? "";
  }

  @override
  void didUpdateWidget(covariant AddUpdateGameModeDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    _nameController.text = widget.initialGameMode?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.initialGameMode != null ? "Modifier le mode de jeu" : "Créer une mode de jeu",
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
                labelText: "Le nom du mode",
                hintText: "Le nom du mode...",
              ),
              validator: FormValidator.requiredValidator,
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(onPressed: _onAddMode, child: Text(widget.initialGameMode != null ? "Modifier" : "Créer"))
          ],
        ),
      ),
    );
  }

  Future<void> _onAddMode() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _errorMessage = "";
      LoadingOverlay.of(context).show();
    });

    try {
      if (widget.initialGameMode != null) {
        await GameModesService.instance
            .update(widget.initialGameMode!.id, _nameController.text, widget.gameID, groupCode: ref.read(authenticationProvider)!.code);
      } else {
        await GameModesService.instance.create(_nameController.text, widget.gameID, groupCode: ref.read(authenticationProvider)!.code);
      }

      if (mounted) {
        LoadingOverlay.of(context).hide();
        Navigator.of(context).pop(true);
      }
    } on Exception {
      setState(() {
        _errorMessage = "Opération impossible...";
        LoadingOverlay.of(context).hide();
      });
    }
  }
}
