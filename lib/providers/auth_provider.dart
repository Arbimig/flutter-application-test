import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/shared_prefs_service.dart';

final sharedPrefsProvider = Provider<SharedPrefsService>((ref) {
  return SharedPrefsService();
});

final authProvider = StateNotifierProvider<AuthProvider, User?>((ref) {
  final prefs = ref.read(sharedPrefsProvider);
  return AuthProvider(prefs);
});

class AuthProvider extends StateNotifier<User?> {
  final SharedPrefsService prefsService;

  AuthProvider(this.prefsService) : super(null) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await prefsService.getUser();
    if (user != null) {
      state = user;
    }
  }

  Future<void> login(String phone) async {
    final user = User(
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      phone: phone,
    );
    await prefsService.saveUser(user);
    await prefsService.saveBalance(user.uid, 0);
    state = user;
  }

  Future<void> logout() async {
    await prefsService.clearUser();
    state = null;
  }
}
