import 'package:flutter/material.dart';
import 'package:flutter_application_test/providers/auth_provider.dart';
import 'package:flutter_application_test/screens/auth_screen.dart';
import 'package:flutter_application_test/core/widgets/simple_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/balance_provider.dart';
import '../services/notification_service.dart';

class BalanceScreen extends ConsumerWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(balanceProvider);
    final controller = ref.read(balanceProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Баланс',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              NotificationService.showLocalNotification(
                id: 0,
                title: 'Баланс',
                body: 'Нажмите, чтобы открыть баланс',
                payload: 'balance',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            tooltip: 'Выйти',
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ваш баланс:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$balance зв.',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),

              GestureDetector(
                onLongPress: () async {
                  await controller.add10();
                },
                child: SimpleButton(text: 'Купить 10', onTap: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
