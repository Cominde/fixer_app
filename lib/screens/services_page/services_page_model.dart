import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'services_page.dart' show ServicesPage;
import 'package:flutter/material.dart';

class ServicesPageModel extends FlutterFlowModel<ServicesPage> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}
