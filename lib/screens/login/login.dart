import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fixer_app/cubit/cubit.dart';
import 'package:fixer_app/cubit/states.dart';
import 'package:fixer_app/screens/accounts/accounts.dart';
import 'package:fixer_app/screens/forget_password/forget_password.dart';
import 'package:fixer_app/screens/layout/layout.dart';
import 'package:fixer_app/shared/components.dart';
import 'package:fixer_app/shared/flutter_flow_theme.dart';
/*import 'package:fixer_app/variables/language/language.dart';*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

/*import 'dart:ui' as ui;*/



class Login extends StatefulWidget {
  final Map<String, List<String>> savedAccounts;

  const Login({super.key, required this.savedAccounts});
  @override
  State<Login> createState() => _LoginStateState();
}

class _LoginStateState extends State<Login> {
    var codeController = TextEditingController();

  var passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return BlocConsumer<AppCubit,AppCubitStates>(
      listener: (context, state) {
        if (state is AppLoginSuccessState)
          {

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Layout(),
                ));
            showToast('Login Successfully');
          }

        else if (state is AppLoginErrorState)
          {
            //print(state.error);
            showToast('Failed to Login');
          }

      },
      builder:(context, state) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).tertiary,
          body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).tertiary,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/34193997432.png',
                ).image,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xCC222222),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 70),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: 160,
                                height: 90,
                                fit: BoxFit.fitWidth,
                              ),
                              /*Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      engApp = !engApp;
                                    });
                                  },
                                  child: engApp
                                      ? Text(
                                    "E",
                                    style: TextStyle(
                                      color: Color(0xFF95A1AC),
                                      fontSize: 20,
                                    ),
                                  )
                                      : Text(
                                    "ع",
                                    style: TextStyle(
                                      color: Color(0xFF95A1AC),
                                      fontSize: 20,
                                    ),
                                    textDirection: ui.TextDirection.rtl,
                                  ),
                                ),
                              )*/
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Welcome!',
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                fontFamily: 'Outfit',
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 24),
                                child: Text(
                                  'To the future of car service',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: codeController,
                                  //  focusNode: _model.codeFocusNode,
                                  textInputAction: TextInputAction.next,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Code',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: const Color(0xFFF68B1E),
                                    ),
                                    hintStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFDBE2E7),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                        16, 24, 0, 24),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color:
                                    FlutterFlowTheme.of(context).tertiary,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your code';
                                    }
                                    return null;
                                  },
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.allow(RegExp(
                                  //       'FilteringTextInputFormatter.deny(RegExp(r\'\\s\'))'))
                                  // ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: passwordController,
                                  // focusNode: _model.codeFocusNode,
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: const Color(0xFFF68B1E),
                                    ),
                                    //  hintText: 'Enter your passwoed here...',
                                    hintStyle:
                                    FlutterFlowTheme.of(context).bodySmall,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFDBE2E7),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                        16, 24, 0, 24),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color:
                                    FlutterFlowTheme.of(context).tertiary,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your password';
                                    }
                                    return null;
                                  },
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.allow(RegExp(
                                  //       'FilteringTextInputFormatter.deny(RegExp(r\'\\s\'))'))
                                  // ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  /*context.pushNamed('createAccount');*/
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Don\'t have an account?',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      'Visit our center to create \nan account',
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ConditionalBuilder(
                                condition: state is AppLoginLoadingState,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: SpinKitDualRing(
                                        color: Color(0xFFF68B1E),
                                        size: 30,
                                      ),
                                    ),
                                  );
                                },
                                fallback: (BuildContext context) {
                                  return  FFButtonWidget(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {

                                        AppCubit.get(context).loginByCode(
                                          carCode: codeController.text,
                                          password: passwordController.text,
                                        );

                                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Layout(),));
                                      }
                                    },
                                    text: 'Login',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width * 0.35,
                                      height: MediaQuery.sizeOf(context).height * 0.065,
                                      padding:
                                      const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      color: const Color(0xFFF68B1E),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      elevation: 3,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  );
                                },

                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if(widget.savedAccounts['codes']!.isNotEmpty)Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            //print(widget.savedAccounts);
                                            //print('----------------------');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>Accounts(savedAccounts: widget.savedAccounts,),
                                                ));
                                          },
                                          text: 'Login with saved account?',
                                          options: FFButtonOptions(
                                            width: 200,
                                            height: 30,
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            color: const Color(0x00FFFFFF),
                                            textStyle: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            elevation: 0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 24),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>const ForgotPassword(),
                                                ));
                                          },
                                          text: 'Forgot your password?',
                                          options: FFButtonOptions(
                                            width: 170,
                                            height: 30,
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                            color: const Color(0x00FFFFFF),
                                            textStyle: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            elevation: 0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                        ),
                                      ),
                                      AutoSizeText(
                                        'Visit our Social Pages',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.getFont(
                                          'Lexend Deca',
                                          color: const Color(0xB2FFFFFF),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 8, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onTap: () async {
                                                  await launchUrl(Uri.parse('https://www.instagram.com/fixer.car.services?igsh=MTh4ZTNiOGRwOW9oeA=='));
                                                },
                                                child: Card(
                                                  clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(50),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/instagram.png',
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 8, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onTap: () async {
                                                  await launchUrl(Uri.parse('https://www.facebook.com/CarsFixer?mibextid=ZbWKwL'));
                                                },
                                                child: Card(
                                                  clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                                  color: const Color(0xFF090F13),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(50),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/facebook.png',
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 8, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onTap: () async {
                                                  await launchUrl(Uri.parse('https://wa.me/201208799962'));
                                                },
                                                child: Card(
                                                  clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                                  color: const Color(0xFF090F13),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(50),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/whatsapp.png',
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: () async {
                                                await launchUrl(Uri(scheme: 'tel', path: '01208799962',));
                                              },
                                              child: Card(
                                                clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                                color: const Color(0xFF090F13),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                ),
                                                child: Image.asset(
                                                  'assets/images/telephone.png',
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
