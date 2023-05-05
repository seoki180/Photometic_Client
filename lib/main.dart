import 'package:flutter/material.dart';
import 'package:photometic/models/login_model.dart';
import 'package:photometic/models/register_model.dart';
import 'package:photometic/providers/photo_provider.dart';
import 'package:photometic/providers/user_provider.dart';
import 'package:photometic/repositories/user_%20repositories.dart';
import 'package:photometic/screen/home_screen.dart';
import 'package:photometic/screen/login_screen.dart';
import 'package:photometic/screen/register_screen.dart';
import 'package:photometic/screen/spash_screen.dart';
import 'package:photometic/screen/start_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepositories = UserRepositories();
    final userProvider = UserProvider(userRepositories: userRepositories);
    final photosProvider = PhotoProvider(userRepositories: userRepositories);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginModel()),
        ChangeNotifierProvider(create: (_) => RegisterModel()),
        ChangeNotifierProvider(create: (_) => userProvider),
        ChangeNotifierProvider(create: (_) => photosProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/start': (context) => const StartScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
