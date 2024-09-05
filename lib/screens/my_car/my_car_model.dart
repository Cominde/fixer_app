import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'my_car.dart' show MyCar;
import 'package:flutter/material.dart';

class EditCarModel extends FlutterFlowModel<MyCar> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for carName widget.
  FocusNode? carNameFocusNode;
  TextEditingController? carNameController;
  String? Function(BuildContext, String?)? carNameControllerValidator;
  // State field(s) for carColor widget.
  FocusNode? carColorFocusNode;
  TextEditingController? carColorController;
  String? Function(BuildContext, String?)? carColorControllerValidator;
  // State field(s) for carMileage widget.
  FocusNode? carMileageFocusNode;
  TextEditingController? carMileageController;
  String? Function(BuildContext, String?)? carMileageControllerValidator;
  // State field(s) for tempDefault widget.
  FocusNode? tempDefaultFocusNode1;
  TextEditingController? tempDefaultController1;
  String? Function(BuildContext, String?)? tempDefaultController1Validator;
  // State field(s) for tempDefault widget.
  FocusNode? tempDefaultFocusNode2;
  TextEditingController? tempDefaultController2;
  // State field(s) for tempDefault widget.
  FocusNode? tempDefaultFocusNode3;
  TextEditingController? tempDefaultController3;
  String? Function(BuildContext, String?)? tempDefaultController2Validator;
  // State field(s) for emailField widget.
  FocusNode? carNumberFocusNode1;
  TextEditingController? carNumberController1;
  String? Function(BuildContext, String?)? carNumberController1Validator;
  // State field(s) for emailField widget.


  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    carNameFocusNode?.dispose();
    carNameController?.dispose();

    carColorFocusNode?.dispose();
    carColorController?.dispose();

    carMileageFocusNode?.dispose();
    carMileageController?.dispose();

    tempDefaultFocusNode1?.dispose();
    tempDefaultController1?.dispose();

    tempDefaultFocusNode2?.dispose();
    tempDefaultController2?.dispose();

    carNumberFocusNode1?.dispose();
    carNumberController1?.dispose();

  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}
