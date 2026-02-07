import 'package:flutter/material.dart';
import 'package:gridbound_galaxy/game/game_page.dart';
import 'package:gridbound_galaxy/modules/levels/presentation/levels_page.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gridbound_galaxy/modules/home/presentation/main_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'config/theme/theme.dart';
import 'config/theme/utils.dart';

class GridboundGalaxy extends StatelessWidget {
  const GridboundGalaxy({super.key});

  ThemeData _buildTheme(BuildContext context, bool isDark) {
    final textTheme = createTextTheme(context);
    final theme = MaterialTheme(textTheme);

    return isDark ? theme.dark() : theme.light();
  }

  @override
  Widget build(BuildContext context) {
    final darkThemeData = _buildTheme(context, true);
    return ResponsiveSizer(
      builder:
          (
            BuildContext context,
            Orientation orientation,
            ScreenType screenType,
          ) => MaterialApp(
            title: 'Gridbound Galaxy',
            debugShowCheckedModeBanner: false,
            theme: darkThemeData,
            darkTheme: darkThemeData,
            themeMode: ThemeMode.dark,
            routes: {
              '/': (context) => const MainPage(),
              '/levels': (context) => const LevelsPage(),
              '/game_page': (context) => const GamePage(),
            },
            // localizationsDelegates: const [
            //   GlobalCupertinoLocalizations.delegate,
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            // ],
            // supportedLocales: const [Locale('ar', '')],
            // locale: const Locale('ar', ''),
          ),
    );
  }
}
