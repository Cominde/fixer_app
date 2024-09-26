import 'dart:convert';

import 'package:fixer_app/cubit/cubit.dart';
import 'package:fixer_app/cubit/states.dart';
import 'package:fixer_app/screens/accounts/accounts.dart';
import 'package:fixer_app/screens/login/login.dart';
import 'package:fixer_app/screens/new_update.dart';
import 'package:fixer_app/screens/onboarding/onboarding.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool onBoarding=CacheHelper.getData('onBoarding')??true ;
  List<String> savedCodes = (CacheHelper.getData('codes') as List?)?.whereType<String>().toList() ?? <String>[];
  List<String> savedPasswords = (CacheHelper.getData('passwords') as List?)?.whereType<String>().toList()??<String>[];
  List<String> savedCarsInfo = (CacheHelper.getData('carsInfo') as List?)?.whereType<String>().toList()??<String>[];
  Map<String, List<String>> savedAccounts={
   'codes':savedCodes,
   'passwords':savedPasswords,
   'carsInfo':savedCarsInfo,
  };

  runApp( MyApp(onBoarding, savedAccounts));
}

class MyApp extends StatefulWidget {
  final bool onBoarding;
  final Map<String, List<String>> savedAccounts;
  const MyApp(this.onBoarding, this.savedAccounts, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool? updatedApp;
  @override
  void initState() {
    get(Uri.parse('https://fixer-backend-rtw4.onrender.com/api/V1/appVersion')).then((value) {
      setState(() {
        updatedApp = json.decode(value.body)[0]['version'].toString() == "1.2.0";
      });
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AppCubit(),
    child: BlocConsumer<AppCubit,AppCubitStates>(
      listener: (BuildContext context, AppCubitStates state) {  },
      builder: (context, state) {
        return AdaptiveTheme(
          light: ThemeData(
            colorScheme: const ColorScheme.light(primary: Color(0xFFF68B1E)),

            useMaterial3: true,
            brightness: Brightness.light,

          ),
          dark: ThemeData(
            colorScheme: const ColorScheme.dark(primary: Color(0xFFF68B1E)),

            useMaterial3: true,
            brightness: Brightness.dark,

          ),
          initial: AdaptiveThemeMode.light,
          builder: (theme, darkTheme) => MaterialApp(
            title: 'Fixer',
            theme: theme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: updatedApp == null ? const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: SpinKitDualRing(
                  color: Color(0xFFF68B1E),
                  size: 50,
                ),
              ),
            ) : (updatedApp! ? (widget.onBoarding?const Onboarding():widget.savedAccounts['codes']!.isNotEmpty?Accounts(savedAccounts: widget.savedAccounts,):Login(savedAccounts: widget.savedAccounts,)) : const NewUpdateScreen()),
          ),
        );
      },

    )

      ,
    );


  }
}
