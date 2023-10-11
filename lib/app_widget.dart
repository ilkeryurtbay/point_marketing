import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:point_marketing/core/theme/app_theme.dart';
import 'package:point_marketing/core/theme/app_theme_mode_enum.dart';
import 'package:point_marketing/core/theme/app_theme_provider.dart';
import 'package:point_marketing/core/util/dismiss_keyboard.dart';
import 'package:point_marketing/src/features/admin/application/selected_product_provider.dart';
import 'package:point_marketing/src/features/admin/application/validation_provider.dart';
import 'package:point_marketing/src/features/admin/presentation/admin_page.dart';
import 'package:point_marketing/src/features/mission/presentation/agent_mission_form.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SelectedProductProvider>(
            create: (context) => SelectedProductProvider(),
          ),
          ChangeNotifierProvider<AppThemeProvider>(
            create: (context) => AppThemeProvider(),
          ),
          ChangeNotifierProvider<ValidationProvider>(
            create: (context) => ValidationProvider(),
          ),
        ],
        builder: (context, child) {
          final currentTheme =
              Provider.of<AppThemeProvider>(context, listen: false)
                  .currentTheme;
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: currentTheme == AppThemeMode.light
                    ? Brightness.light
                    : Brightness.dark,
                statusBarIconBrightness: currentTheme == AppThemeMode.light
                    ? Brightness.dark
                    : Brightness.light),
          );
          return DismissKeyboard(
            //Dismiss keyboard and remove focus when tapped outside of a text field app wide
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: currentTheme == AppThemeMode.light
                  ? AppTheme.lightTheme
                  : AppTheme.darkTheme,
              home: const AdminPage(),
            ),
          );
        });
  }
}
