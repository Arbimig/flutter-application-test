import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/shared_prefs_service.dart';
import '../models/user.dart';
import 'auth_provider.dart';

final balanceProvider = StateNotifierProvider<BalanceProvider, int>((ref) {
  final prefs = ref.read(sharedPrefsProvider);
  final user = ref.watch(authProvider);
  return BalanceProvider(prefs, user);
});

class BalanceProvider extends StateNotifier<int> {
  final SharedPrefsService prefs;
  final User? user;

  BalanceProvider(this.prefs, this.user) : super(0) {
    if (user != null) {
      _loadBalance();
    }
  }

  Future<void> _loadBalance() async {
    final saved = await prefs.getBalance(user!.phone);
    state = saved;
  }

  Future<void> add10() async {
    if (user == null) return;
    final newBalance = state + 10;
    state = newBalance;
    await prefs.saveBalance(user!.phone, newBalance);
  }
}