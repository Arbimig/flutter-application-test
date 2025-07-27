import 'package:flutter/material.dart';
import 'package:flutter_application_test/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/auth_screen.dart';
import 'screens/balance_screen.dart';
import 'main.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      navigatorKey: navigatorKey,
      routes: {'/balance': (_) => const BalanceScreen()},
      home: authState == null ? const AuthScreen() : const BalanceScreen(),
    );
  }
}
