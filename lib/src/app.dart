import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:safeonaut/src/drug-testing/models/test_group.dart';
import 'package:safeonaut/src/drug-testing/widgets/test-view/test_view.dart';
import 'package:safeonaut/src/drug-testing/widgets/testgroup_detailedview.dart';
import 'package:safeonaut/src/drug-testing/widgets/testgroups_overview.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData().copyWith(
            primaryColor: Colors.black,
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.black,
                  secondary: Colors.black,
                  background: Colors.white,
                ),
            appBarTheme: ThemeData().appBarTheme.copyWith(
                  foregroundColor: Colors.black,
                  backgroundColor: ThemeData().scaffoldBackgroundColor,
                  elevation: 0,
                ),
            tabBarTheme: ThemeData().tabBarTheme.copyWith(
                  labelColor: Colors.black,
                ),
            // Make dividers transparent for expansion tile cards.
            dividerColor: Colors.transparent,
            // Set indicator color for tab bar.
            indicatorColor: Colors.black,
          ),
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: Colors.black,
            colorScheme: ThemeData.dark().colorScheme.copyWith(
                  primary: Colors.white,
                  onPrimary: ThemeData.dark().scaffoldBackgroundColor,
                  secondary: Colors.white,
                  background: Colors.grey[800],
                ),
            appBarTheme: ThemeData.dark().appBarTheme.copyWith(
                  foregroundColor: Colors.white,
                  backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
                  elevation: 0,
                ),
            dividerColor: Colors.transparent,
            indicatorColor: Colors.white,
          ),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case TestGroupDetailedView.routeName:
                    return TestGroupDetailedView(
                      settingsController: settingsController,
                      testGroup: routeSettings.arguments as TestGroup,
                    );
                  case TestView.routeName:
                    return TestView(
                        args: routeSettings.arguments as TestViewArgument);
                  case TestGroupsOverviewView.routeName:
                  default:
                    return TestGroupsOverviewView(
                      settingsController: settingsController,
                    );
                }
              },
            );
          },
        );
      },
    );
  }
}
