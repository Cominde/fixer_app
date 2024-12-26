import 'dart:developer';
import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  try {
    await integrationDriver(
      onScreenshot: (screenshotName, screenshotBytes, [args]) async {
        final directory = Directory('screenshots');
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }
        final File image = File('${directory.path}/$screenshotName.png');
        image.writeAsBytesSync(screenshotBytes);
        log('Screenshot saved: ${image.path}');
        return true;
      },
    );
  } catch (e) {
    log('Error occurred: $e');
  }
}