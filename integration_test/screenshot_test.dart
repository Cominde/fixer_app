import 'dart:io';
import 'package:fixer_app/network/local/cache_helper.dart';
import 'package:fixer_app/network/remote/dio_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fixer_app/main.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:easy_localization/easy_localization.dart';
import 'package:fixer_app/cubit/cubit.dart';
import 'package:fixer_app/shared/codegen_loader.g.dart';
import 'package:fixer_app/shared/constant_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {

  final IntegrationTestWidgetsFlutterBinding binding = IntegrationTestWidgetsFlutterBinding();

  testWidgets('screenshot', (WidgetTester tester) async {
    // Render the UI of the app
    await tester.pumpWidget(EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        fallbackLocale: Locale(ConstantData.kDefaultLung),
        startLocale: Locale('en'),
        assetLoader: const CodegenLoader(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider (create: (BuildContext context) => AppCubit(),),
          ],
          child: MyApp(true, {}),))
    );

    String platformName = '';

    if (!kIsWeb) {
      // Not required for the web. This is required prior to taking the screenshot.
      await binding.convertFlutterSurfaceToImage();

      if (Platform.isAndroid) {
        platformName = "android";
      } else {
        platformName = "ios";
      }
    } else {
      platformName = "web";
    }

    DioHelper.init();
    await CacheHelper.init();

    await tester.pumpAndSettle(); // Take the screenshot
    await binding.takeScreenshot('screenshot-onboarding-screen-$platformName');
    await tester.tap(find.byKey(Key('navigateToLoginScreenButton')));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('screenshot-login-screen-$platformName');
    await tester.enterText(find.byKey(Key('codeField')), 'C156'); // Enter password
    await tester.enterText(find.byKey(Key('passwordField')), '58261585'); // Tap the login button
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('screenshot-home-screen-$platformName');
    await tester.tap(find.byKey(Key('servicesButton')));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('screenshot-services-screen-$platformName');
    await tester.tap(find.byKey(Key('personButton')));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('screenshot-person-screen-$platformName');
  });
}
