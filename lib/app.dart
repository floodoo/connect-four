import 'package:flutter/material.dart';
import 'package:four_wins/core/ui/theme/four_wins.theme.dart';
import 'package:four_wins/features/game_board/game_board.screen.dart';
import 'package:four_wins/features/main_menu/main_menu.screen.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
        routes: [
          GoRoute(
            path: 'play',
            builder: (context, state) => const GameBoard(key: Key('game board')),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: '4 Wins',
      theme: FourWinsTheme.light,
      darkTheme: FourWinsTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
