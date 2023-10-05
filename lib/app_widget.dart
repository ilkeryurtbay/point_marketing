import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:point_marketing/core/theme/app_theme.dart';
import 'package:point_marketing/core/theme/app_theme_mode_enum.dart';
import 'package:point_marketing/core/theme/app_theme_provider.dart';
import 'package:point_marketing/src/features/admin/application/selected_product.dart';
import 'package:point_marketing/src/features/admin/presentation/admin_page.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SelectedProduct>(
            create: (context) => SelectedProduct(),
          ),
          ChangeNotifierProvider<AppThemeProvider>(
            create: (context) => AppThemeProvider(),
          )
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: currentTheme == AppThemeMode.light
                ? AppTheme.lightTheme
                : AppTheme.darkTheme,
            home: const AdminPage(),
          );
        });
  }
}
