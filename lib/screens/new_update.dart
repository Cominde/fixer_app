import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fixer_app/generated/assets.dart';
import 'package:fixer_app/shared/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewUpdateScreen extends StatefulWidget {
  const NewUpdateScreen({super.key});

  @override
  State<NewUpdateScreen> createState() => _NewUpdateScreenState();
}

class _NewUpdateScreenState extends State<NewUpdateScreen> with TickerProviderStateMixin {

  late AnimationController textController;
  late Animation<double> textAnimation;
  late AnimationController buttonController;
  late Animation<double> buttonAnimation;

  @override
  void initState() {
    super.initState();
    textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    buttonController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    textAnimation = CurvedAnimation(
      parent: textController,
      curve: Curves.fastOutSlowIn,
    );
    buttonAnimation = CurvedAnimation(
      parent: buttonController,
      curve: Curves.bounceIn,
      reverseCurve: Curves.slowMiddle
    );
  }

  @override
  void dispose() {
    textController.dispose();
    buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(backgroundColor: FlutterFlowTheme.of(context).primaryBackground,),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: AnimatedBuilder(
              animation: textAnimation,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    boxShadow: [
                      for (int i = 1; i <= 5; i++)
                        BoxShadow(
                          color: const Color(0xFFF68B1E).withOpacity(textAnimation.value / i),
                          spreadRadius: i * 2.0,
                          blurRadius: i * 3.0,
                        ),
                    ],
                  ),
                  child: AutoSizeText(
                    'New Update'.tr(),
                    style: TextStyle(
                      fontSize: 40,
                      color: const Color(0xFFF68B1E),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        for (int i = 1; i <= 3; i++)
                          BoxShadow(
                            color: const Color(0xFFF68B1E).withOpacity(textAnimation.value / i),
                            spreadRadius: i * 2.0,
                            blurRadius: i * 3.0,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                clipBehavior: Clip.antiAlias,
                child: const Image(image: AssetImage(Assets.imagesNewUpdate),)
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AutoSizeText(
              'New Version Available Now'.tr(),
              style: FlutterFlowTheme.of(context).headlineMedium,
            ),
          ),
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: buttonAnimation,
                builder: (context, child) {
                  return GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse('https://files.fm/u/ce6darznrt'));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFF68B1E),
                        boxShadow: [
                          for (int i = 1; i <= 5; i++)
                            BoxShadow(
                              color: const Color(0xFFF68B1E).withOpacity(buttonAnimation.value / i),
                              spreadRadius: i * 2.0,
                              blurRadius: i * 3.0,
                            ),
                        ],
                      ),
                      child: AutoSizeText(
                        'Download New Version'.tr(),
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}


