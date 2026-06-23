import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/auth_provider.dart';
import 'profile_setup_screen.dart';
import 'main_navigation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final authProvider = Provider.of<AuthUserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.language, color: Colors.white70),
            label: Text(
              lang.isEnglish ? "EN" : "ID",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => lang.toggleLanguage(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'VELOCE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Text(
              'T R A C K',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                letterSpacing: 8,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 60),
            Text(
              lang.txtWelcome,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 30),

            authProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFFFF5722)),
                  )
                : ElevatedButton.icon(
                    icon: const Icon(Icons.bolt, color: Colors.black),
                    label: Text(
                      lang.txtLoginBtn,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      bool isUserExist = await authProvider.signInWithGoogle();
                      if (authProvider.user != null) {
                        if (isUserExist) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainNavigation(),
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfileSetupScreen(),
                            ),
                          );
                        }
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
