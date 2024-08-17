import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:fixer_app/cubit/cubit.dart';
import 'package:fixer_app/cubit/states.dart';
import 'package:fixer_app/network/local/cache_helper.dart';
import 'package:fixer_app/screens/accounts/accounts.dart';
import 'package:fixer_app/screens/login/login.dart';
import 'package:fixer_app/screens/my_car/my_car.dart';
import 'package:fixer_app/screens/my_profile/my_profile.dart';
import 'package:fixer_app/shared/flutter_flow_theme.dart';
/*import 'package:fixer_app/variables/language/language.dart';*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
/*import 'dart:ui' as ui;*/

import 'profile_page_model.dart';
export 'profile_page_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late ProfilePageModel _model;

  bool loading = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasContainerTriggered1 = false;
  var hasContainerTriggered2 = false;
  /*var hasContainerTriggered3 = false;
  var hasContainerTriggered4 = false;*/
  final animationsMap = {
    'containerOnActionTriggerAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effectsBuilder: () => [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 350.ms,
          begin: const Offset(40, 0),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'containerOnActionTriggerAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effectsBuilder: () => [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 350.ms,
          begin: const Offset(-40, 0),
          end: const Offset(0, 0),
        ),
      ],
    ),
  };
  /*final animationsMap2 = {
    'containerOnActionTriggerAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 350.ms,
          begin: Offset(40, 0),
          end: Offset(0, 0),
        ),
      ],
    ),
    'containerOnActionTriggerAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 350.ms,
          begin: Offset(-40, 0),
          end: Offset(0, 0),
        ),
      ],
    ),
  };*/

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    /*setupAnimations(
      animationsMap2.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );*/
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

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

    return BlocConsumer<AppCubit, AppCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          top: true,
          child: loading
              ? const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: SpinKitDualRing(
                      color: Color(0xFFF68B1E),
                      size: 50,
                    ),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 160,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: const Color(0xFFF68B1E),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'assets/images/man.png',
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${AppCubit.get(context).loginByCodeModel!.userData!.name}',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 0),
                                          child: Text(
                                            '${AppCubit.get(context).loginByCodeModel!.userData!.email}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                /*Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (!(Theme.of(context).brightness ==
                                  Brightness.dark))
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    /*setDarkModeSetting(context, ThemeMode.dark);*/
                                    AdaptiveTheme.of(context).setDark();
                                    if (animationsMap[
                                            'containerOnActionTriggerAnimation2'] !=
                                        null) {
                                      setState(
                                          () => hasContainerTriggered2 = true);
                                      animationsMap[
                                              'containerOnActionTriggerAnimation2']!
                                          .controller
                                          .duration = const Duration(milliseconds: 350);
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) async =>
                                              await animationsMap[
                                                      'containerOnActionTriggerAnimation2']!
                                                  .controller
                                                  .forward(from: 0.0));
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          24, 12, 24, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Switch to Dark Mode',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                          Container(
                                            width: 80,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Stack(
                                              alignment:
                                                  const AlignmentDirectional(0, 0),
                                              children: [
                                                const Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.95, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 8, 0),
                                                    child: Icon(
                                                      Icons.nights_stay,
                                                      color: Color(0xFF95A1AC),
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          -0.85, 0),
                                                  child: Container(
                                                    width: 36,
                                                    height: 36,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          blurRadius: 4,
                                                          color:
                                                              Color(0x430B0D0F),
                                                          offset: Offset(0, 2),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                  ).animateOnActionTrigger(
                                                      animationsMap[
                                                          'containerOnActionTriggerAnimation1']!,
                                                      hasBeenTriggered:
                                                          hasContainerTriggered1),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (Theme.of(context).brightness ==
                                  Brightness.dark)
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    /*setDarkModeSetting(context, ThemeMode.light);*/
                                    AdaptiveTheme.of(context).setLight();
                                    if (animationsMap[
                                            'containerOnActionTriggerAnimation1'] !=
                                        null) {
                                      animationsMap[
                                              'containerOnActionTriggerAnimation1']!
                                          .controller
                                          .duration = const Duration(milliseconds: 350);
                                      setState(
                                          () => hasContainerTriggered1 = true);
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) async =>
                                              await animationsMap[
                                                      'containerOnActionTriggerAnimation1']!
                                                  .controller
                                                  .forward(from: 0.0));
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 1,
                                          color: Color(0xFF1A1F24),
                                          offset: Offset(0, 0),
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          24, 12, 24, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Switch to Light Mode',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                          Container(
                                            width: 80,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF1D2429),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Stack(
                                              alignment:
                                                  const AlignmentDirectional(0, 0),
                                              children: [
                                                const Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -0.9, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 2, 0, 0),
                                                    child: Icon(
                                                      Icons.wb_sunny_rounded,
                                                      color: Color(0xFF95A1AC),
                                                      size: 24,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.9, 0),
                                                  child: Container(
                                                    width: 36,
                                                    height: 36,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF14181B),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          blurRadius: 4,
                                                          color:
                                                              Color(0x430B0D0F),
                                                          offset: Offset(0, 2),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                  ).animateOnActionTrigger(
                                                      animationsMap[
                                                          'containerOnActionTriggerAnimation2']!,
                                                      hasBeenTriggered:
                                                          hasContainerTriggered2),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        /*Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (engApp)
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          setState(() {
                            engApp = false;
                          });
                          if (animationsMap2['containerOnActionTriggerAnimation2'] != null) {
                            setState(() => hasContainerTriggered4 = true);
                            animationsMap2['containerOnActionTriggerAnimation2']!.controller.duration = Duration(milliseconds: 350);
                            SchedulerBinding.instance.addPostFrameCallback(
                                    (_) async => await animationsMap2['containerOnActionTriggerAnimation2']!.controller.forward(from: 0.0)
                            );
                          }
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24, 12, 24, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Switch to Arabic',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium,
                                ),
                                Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional(0, 0),
                                    children: [
                                      Align(
                                        alignment:
                                        AlignmentDirectional(0.95, 0),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 12, 5),
                                          child: Text(
                                            "ع",
                                            style: TextStyle(
                                              color: Color(0xFF95A1AC),
                                              fontSize: 20,
                                            ),
                                            textDirection: ui.TextDirection.rtl,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                        AlignmentDirectional(-0.85, 0),
                                        child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x430B0D0F),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ).animateOnActionTrigger(
                                            animationsMap2[
                                            'containerOnActionTriggerAnimation1']!,
                                            hasBeenTriggered:
                                            hasContainerTriggered3),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (!engApp)
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          setState(() {
                            engApp = true;
                          });
                          if (animationsMap2[
                          'containerOnActionTriggerAnimation1'] !=
                              null) {
                            animationsMap2['containerOnActionTriggerAnimation1']!.controller.duration = Duration(milliseconds: 350);
                            setState(() => hasContainerTriggered3 = true);
                            SchedulerBinding.instance.addPostFrameCallback(
                                    (_) async => await animationsMap2[
                                'containerOnActionTriggerAnimation1']!
                                    .controller
                                    .forward(from: 0.0));
                          }
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24, 12, 24, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Switch to English',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium,
                                ),
                                Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional(0, 0),
                                    children: [
                                      Align(
                                        alignment:
                                        AlignmentDirectional(-0.9, 0),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(8, 2, 0, 0),
                                          child: Text(
                                            "E",
                                            style: TextStyle(
                                              color: Color(0xFF95A1AC),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                        AlignmentDirectional(0.9, 0),
                                        child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x430B0D0F),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ).animateOnActionTrigger(
                                            animationsMap2[
                                            'containerOnActionTriggerAnimation2']!,
                                            hasBeenTriggered:
                                            hasContainerTriggered4),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),*/
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MyCar(),
                                      ));
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.4),
                                        width: 2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 4, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'My Car',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                          const Icon(
                                            Icons.chevron_right_rounded,
                                            color: Color(0xFF95A1AC),
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  /*context.pushNamed('editProfile');*/
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MyProfile(),
                                      ));
                                },
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.4),
                                        width: 2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 4, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'My Profile',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                        const Icon(
                                              Icons.chevron_right_rounded,
                                              color: Color(0xFF95A1AC),
                                              size: 20,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 40),
                          child: FFButtonWidget(
                            onPressed: () async {
                              AppCubit.get(context).getCarByNumberModel = null;
                              AppCubit.get(context).loginByCodeModel = null;
                              AppCubit.get(context).forgetPasswordModel = null;
                              AppCubit.get(context).getServicesModel = null;

                              List<String> savedCodes=CacheHelper.getData('codes').whereType<String>().toList()??<String>[];
                              List<String> savedPasswords=CacheHelper.getData('passwords').whereType<String>().toList()??<String>[];
                              List<String> savedCarsInfo=CacheHelper.getData('carsInfo').whereType<String>().toList()??<String>[];
                              Map<String, List<String>> savedAccounts={
                                'codes':savedCodes,
                                'passwords':savedPasswords,
                                'carsInfo':savedCarsInfo,
                              };

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => savedAccounts['codes']!.isNotEmpty?Accounts(savedAccounts: savedAccounts,):Login(savedAccounts: savedAccounts,),
                                  ));
                            },
                            text: 'Log Out',
                            options: FFButtonOptions(
                              width: 110,
                              height: 50,
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Colors.grey.withOpacity(0.4),
                              textStyle:
                                  FlutterFlowTheme.of(context).titleSmall,
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.4),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }
}
