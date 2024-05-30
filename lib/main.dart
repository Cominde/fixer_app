import 'package:fixer_app/cubit/cubit.dart';
import 'package:fixer_app/cubit/states.dart';
import 'package:fixer_app/screens/accounts/accounts.dart';
import 'package:fixer_app/screens/login/login.dart';
import 'package:fixer_app/screens/onboarding/onboarding.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool onBoarding=CacheHelper.getData('onBoarding')??true ;
  List<String> savedCodes = CacheHelper.getData('codes').whereType<String>().toList()??<String>[];
  List<String> savedPasswords = CacheHelper.getData('passwords').whereType<String>().toList()??<String>[];
  List<String> savedCarsInfo = CacheHelper.getData('carsInfo').whereType<String>().toList()??<String>[];
  Map<String, List<String>> savedAccounts={
   'codes':savedCodes,
   'passwords':savedPasswords,
   'carsInfo':savedCarsInfo,
  };
  runApp( MyApp(onBoarding, savedAccounts));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Map<String, List<String>> savedAccounts;
  const MyApp(this.onBoarding, this.savedAccounts, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme.of(context).primary = const Color(0xFFF68B1E);

    return BlocProvider(create: (context) => AppCubit(),
    child: BlocConsumer<AppCubit,AppCubitStates>(
      listener: (BuildContext context, AppCubitStates state) {  },
      builder: (context, state) {
        return AdaptiveTheme(
          light: ThemeData(
            colorScheme: const ColorScheme.light(primary: Colors.deepOrange),

            useMaterial3: true,
            brightness: Brightness.light,

          ),
          dark: ThemeData(
            colorScheme: const ColorScheme.dark(primary: Colors.deepOrange),

            useMaterial3: true,
            brightness: Brightness.dark,

          ),
          initial: AdaptiveThemeMode.light,
          builder: (theme, darkTheme) => MaterialApp(
            title: 'Fixer',
            theme: theme,
            darkTheme: darkTheme,
            home: onBoarding?const Onboarding():savedAccounts['codes']!.isNotEmpty?Accounts(savedAccounts: savedAccounts,):Login(savedAccounts: savedAccounts,),
          ),
        );
      },

    )

      ,
    );


  }
}
