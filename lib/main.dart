import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/language_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AuthUserProvider()),
      ],
      child: const VeloceTrackApp(),
    ),
  );
}

class VeloceTrackApp extends StatelessWidget {
  const VeloceTrackApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Veloce Track',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFFF5722),
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF5722),
          secondary: Color(0xFF00E676),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
