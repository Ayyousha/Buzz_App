
import 'package:buzz_app/modules/onboarding/onboarding_screen.dart';
import 'package:buzz_app/shared/bloc/shared_bloc.dart';
import 'package:buzz_app/shared/style/buzz_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'layout/home_provider/home_bloc.dart';
import 'modules/splash/splash_screen.dart';
import 'shared/network/local/cach_helper.dart';
import 'shared/network/remote/dio_helper.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp();
  bool isDark = CacheHelper.getData(key: 'isDark');


  runApp( MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {

  final _sharedProvider = SharedCubit();
  final _homeProvider = HomeProvider();
  final bool? isDark;

  MyApp({
     this.isDark,
});




  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => _homeProvider
            ..changeScreen(DrawerSections.newNews)
            ..currentIndex
            ..getNewNews()
            ..getFutureNews()
            ..getNewsImages()
            ..getBusiness()
            ..getSports()
            ..getScience(),
          ),
          ChangeNotifierProvider(create: (context) => _sharedProvider
             ..changeThemeMode(sharedType: isDark),
          ),
        ],
      child: Consumer<SharedCubit>(
        builder: (context, provider,child) {

          ThemeData theme;
          if(provider.isDark)
          {
            theme = BuzzTheme.dark();
          } else
            {
            theme = BuzzTheme.light();
            }

          return MaterialApp(
            theme: theme,
            debugShowCheckedModeBanner: false,
            home:  SplashScreen(),
          );
        },
      )
    );
  }
}


