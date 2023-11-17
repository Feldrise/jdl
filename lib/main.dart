import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jdl/features/authentication/authentication_provider.dart';
import 'package:jdl/features/authentication/models/group/group.dart';
import 'package:jdl/features/navigation/routes.dart';
import 'package:jdl/theme/jdl_theme.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref.read(authenticationProvider.notifier).initialGroup(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Image.asset(
              "assets/backgrounds/plants.png",
              fit: BoxFit.cover,
            );
          }

          return Builder(builder: (context) {
            final Group? watchedGroup = ref.watch(authenticationProvider);

            return MaterialApp.router(
              theme: JDLTheme.theme(),
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              supportedLocales: const [Locale("fr")],
              routerConfig: router(watchedGroup),
            );
          });
        });
  }
}
