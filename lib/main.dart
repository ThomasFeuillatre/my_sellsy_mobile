import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_sellsy/router.dart';
import 'package:my_sellsy/utils/app_colors.dart';

import 'models/user.dart';

void main() {
  runApp(const ProviderScope(child: MySellsyApp()));
}

class MySellsyApp extends ConsumerWidget {
  const MySellsyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(syncRouterProvider);

    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      title: 'flutter_riverpod + go_router Demo',
      theme: ThemeData(primaryColor: AppColors.darkBlue),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static String get routeName => 'home';
  static String get routeLocation => '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Sellsy App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Homepage"),
            ElevatedButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                },
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
