import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_sellsy/utils/app_colors.dart';

import '../models/user.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String get routeName => 'login';

  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 54),
              child: SvgPicture.asset('assets/logo.svg', width: 250),
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text("Connectez-vous à votre compte", style: TextStyle(color: Colors.white))),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                  foregroundColor: MaterialStatePropertyAll(Colors.black)),
              onPressed: () async {
                ref.read(authProvider.notifier).login(
                      "myEmail",
                      "myPassword",
                    );
              },
              child: const Text("Connexion"),
            ),
          ],
        ),
      ),
    );
  }
}
