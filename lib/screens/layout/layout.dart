import 'package:fixer_app/screens/home_page/home_page.dart';
import 'package:fixer_app/screens/profile_page/profile_page.dart';
import 'package:fixer_app/screens/services_page/services_page.dart';
import 'package:fixer_app/shared/flutter_flow_theme.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'layout_model.dart';
export 'layout_model.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late LayoutModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  int pageNumber = 0;
  List<Widget> pages = [const HomePage(),const ServicesPage(),const ProfilePage()];


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LayoutModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          key: scaffoldKey,
          body: SafeArea(
            top: true,
            child: pages[pageNumber],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.home_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                label: 'Home',
                backgroundColor: Colors.grey.withOpacity(0.4),
                activeIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.home,
                        color: Color(0xFFF68B1E),
                        size: 20,
                      ),
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: Color(0xFFF68B1E),
                      )
                    ],
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.car_repair_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                label: 'Services',
                backgroundColor: Colors.grey.withOpacity(0.4),
                activeIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.car_repair,
                        color: Color(0xFFF68B1E),
                        size: 20,
                      ),
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: Color(0xFFF68B1E),
                      )
                    ],
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                label: 'Person',
                backgroundColor: Colors.grey.withOpacity(0.4),
                activeIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xFFF68B1E),
                        size: 20,
                      ),
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: Color(0xFFF68B1E),
                      )
                    ],
                  ),
                ),
              ),
            ],
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            useLegacyColorScheme: false,
            currentIndex: pageNumber,
            onTap: (int num) {
              setState(() {
                pageNumber = num;
              });
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}