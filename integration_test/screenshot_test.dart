import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fixer_app/main.dart';
import 'package:flutter/foundation.dart' show kIsWeb;



Future<void> main() async {

  final IntegrationTestWidgetsFlutterBinding binding = IntegrationTestWidgetsFlutterBinding();

  testWidgets('screenshot', (WidgetTester tester) async {
    // Render the UI of the app
    await tester.pumpWidget(MyApp(true, {}));

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

    await tester.pumpAndSettle();
    // Take the screenshot
    await binding.takeScreenshot('screenshot-$platformName');
  });
}
