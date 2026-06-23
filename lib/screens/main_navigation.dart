import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthUserProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF00E676),
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Dashboard Active',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'User: ${auth.userProfile?.name ?? "Athlete"}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Focus: ${auth.userProfile?.primarySport ?? "-"}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 40),
            OutlinedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.redAccent),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.redAccent),
              ),
              onPressed: () async {
                await auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
