import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'onboarding.dart' show Onboarding;
import 'package:flutter/material.dart';

class OnboardingModel extends FlutterFlowModel<Onboarding> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
      pageViewController!.hasClients &&
      pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

/// Action blocks are added here.

/// Additional helper methods are added here.
}
