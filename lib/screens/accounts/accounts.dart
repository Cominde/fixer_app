import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fixer_app/cubit/cubit.dart';
import 'package:fixer_app/cubit/states.dart';
import 'package:fixer_app/generated/assets.dart';
import 'package:fixer_app/screens/layout/layout.dart';
import 'package:fixer_app/screens/login/login.dart';
import 'package:fixer_app/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Accounts extends StatefulWidget {
  final Map<String, List<String>> savedAccounts;

  const Accounts({super.key, required this.savedAccounts});

  @override
  State<Accounts> createState() => _LoginStateState();
}

class _LoginStateState extends State<Accounts> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  int selected = -1;

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
          showToast('Login Successfully'.tr());
        }

        else if (state is AppLoginErrorState)
        {
          //print(state.error);
          showToast('Failed to Login'.tr());
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
                  Assets.imagesBackgroundGarage,
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
                              Assets.imagesLogo,
                              width: 160,
                              height: 100,
                              fit: BoxFit.fitWidth,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  context.read<AppCubit>().updateLung(lung: context.locale == const Locale('en')? 'ar':'en', context: context);
                                },
                                child: AutoSizeText(
                                  'E'.tr(),
                                  style: TextStyle(
                                    color: Color(0xFF95A1AC),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          AutoSizeText(
                            'Welcome!'.tr(),
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
                              child: AutoSizeText(
                                'To the future of car service'.tr(),
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
                              child: Padding(
                                padding:
                                const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 24),
                                child: AutoSizeText(
                                  'Your saved accounts'.tr(),
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
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for(int i=0; i<widget.savedAccounts['codes']!.length; i++)...[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    setState(() {
                                      if(selected==i){
                                        selected = -1;
                                      } else {
                                        selected = i;
                                      }
                                    });
                                  },
                                  child: Container(
                                    /*height: ,*/
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground.withOpacity(0.5),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color: Color(0x2B202529),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: i==selected?const Color(0xFFF68B1E):Colors.transparent,width: 1)
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(8, 4, 0, 4),
                                            child: Column(
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                AutoSizeText(
                                                  widget.savedAccounts['carsInfo']![i].toString(),
                                                  style:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .titleMedium
                                                      .override(
                                                    fontFamily:
                                                    'Outfit',
                                                    /*fontSize: 12,*/
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0, 4, 0, 0),
                                                  child: AutoSizeText(
                                                    "${'Code'.tr()}: ${widget.savedAccounts['codes']![i]}",
                                                    style: FlutterFlowTheme
                                                        .of(context)
                                                        .titleSmall,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0, 4, 0, 0),
                                                  child: AutoSizeText(
                                                    "${'Password'.tr()}: ${widget.savedAccounts['passwords']![i]}",
                                                    style: FlutterFlowTheme
                                                        .of(context)
                                                        .titleSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft:
                                            Radius.circular(12),
                                            bottomRight:
                                            Radius.circular(0),
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(0),
                                          ),
                                          child: Image.asset(
                                            Assets.imagesWhiteTeslaCar,
                                            width:
                                            MediaQuery.sizeOf(context)
                                                .width *
                                                0.4,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    'Don\'t have an account?'.tr(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.transparent,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  AutoSizeText(
                                    'Visit our center to create \nan account'.tr(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                              flex: 2,
                              child: ConditionalBuilder(
                                condition: state is AppLoginLoadingState,
                                builder: (BuildContext context) {
                                  return const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                      child: SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: SpinKitDualRing(
                                          color: Color(0xFFF68B1E),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                fallback: (BuildContext context) {
                                  return  FFButtonWidget(
                                    onPressed: () {
                                      if (selected!=-1) {

                                        AppCubit.get(context).loginByCode(
                                          carCode: widget.savedAccounts['codes']![selected],
                                          password: widget.savedAccounts['passwords']![selected],
                                        );

                                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Layout(),));
                                      }
                                    },
                                    text: 'Login'.tr(),
                                    options: FFButtonOptions(
                                      width: 140,
                                      height: 56,
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
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 24),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>Login(savedAccounts: widget.savedAccounts,),
                                              ));
                                        },
                                        text: 'Login with new account?'.tr(),
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
                                    AutoSizeText(
                                      'Visit our Social Pages'.tr(),
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
                                                  Assets.imagesInstagram,
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
                                                  Assets.imagesFacebook,
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
                                                  Assets.imagesWhatsapp,
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
                                                Assets.imagesTelephone,
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
        );
      },
    );
  }
}
