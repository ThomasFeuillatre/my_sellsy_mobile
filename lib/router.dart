import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_sellsy/main.dart';
import 'package:my_sellsy/pages/login_page.dart';

import 'models/user.dart';

final syncRouterProvider = Provider<GoRouter>((ref) {
  final router = MySellsyRouterNotifier(ref);

  return GoRouter(
    debugLogDiagnostics: true, // For demo purposes
    refreshListenable: router, // This notifiies `GoRouter` for refresh events
    redirect: router._redirectLogic,
    routes: router._routes, // All the routes can be found there
  );
});

class MySellsyRouterNotifier extends ChangeNotifier {
  final Ref _ref;
  ProviderSubscription? subscription;

  /// This implementation exploits `ref.listen()` to add a simple callback that
  /// calls `notifyListeners()` whenever there's change onto a desider provider.
  MySellsyRouterNotifier(this._ref) {
    subscription = _ref.listen<User?>(
      authProvider, // In our case, we're interested in the log in / log out events.
      (_, __) => notifyListeners(), // Obviously more logic can be added here
    );
    _ref.onDispose(() {
      subscription?.close();
    });
  }

  @override
  void dispose() {
    subscription?.close();
    super.dispose();
  }

  String? _redirectLogic(BuildContext context, GoRouterState state) {
    final user = _ref.read(authProvider);

    // From here we can use the state and implement our custom logic
    final areWeLoggingIn = state.location == LoginPage.routeLocation;

    if (user == null) {
      // We're not logged in
      // So, IF we aren't in the login page, go there.
      return areWeLoggingIn ? null : LoginPage.routeLocation;
    }
    // We're logged in

    // At this point, IF we're in the login page, go to the home page
    if (areWeLoggingIn) return MyHomePage.routeLocation;

    // There's no need for a redirect at this point.
    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
          name: MyHomePage.routeName,
          path: MyHomePage.routeLocation,
          builder: (context, _) => const MyHomePage(),
        ),
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.routeLocation,
          builder: (context, state) => const LoginPage(
            key: Key('login'),
          ),
        )
      ];
}
