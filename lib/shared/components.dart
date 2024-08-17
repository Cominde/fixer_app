// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fixer_app/cubit/cubit.dart';
import 'package:fixer_app/shared/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/get_services_model.dart';
import '../screens/services_detailes/services_details.dart';


void showToast(String text) => Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );

Widget serviceItemBuilder(Visit model, AppCubit cubit) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
    child: Builder(
      builder: (context) {

          return Padding(
            padding:
            EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ServicesDetails(visit: model, cubit: cubit,),));
              },
              child: ConditionalBuilder(
              condition: model.id==null,
              builder: (context) => Center(child: CircularProgressIndicator(),),
              fallback: (context) => Container(
                width: 100,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context)
                      .secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x2B202529),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          8, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional
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
                                  Text(
                                    '${model.priceAfterDiscount}\$',
                                    style:
                                    FlutterFlowTheme.of(
                                        context)
                                        .bodySmall
                                        .override(
                                      fontFamily:
                                      'Outfit',
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional
                                        .fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      '${model.services.length} Service\$',
                                      style: FlutterFlowTheme
                                          .of(context)
                                          .titleMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional
                                        .fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      '#${model.type}',
                                      style: FlutterFlowTheme
                                          .of(context)
                                          .bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                              Radius.circular(0),
                              bottomRight:
                              Radius.circular(12),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset(
                              'assets/images/41723171321.png',
                              width: 160,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          12, 0, 16, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Card(
                            clipBehavior:
                            Clip.antiAliasWithSaveLayer,
                            color: FlutterFlowTheme.of(context)
                                .primaryText,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(40),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                model.complete!?Icons.done_rounded:Icons.access_time_outlined,
                                color:
                                FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 24,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional
                                  .fromSTEB(12, 0, 0, 0),
                              child: Text(
                                model.complete!?'Completed On':'In Progress',
                                style:
                                FlutterFlowTheme.of(context)
                                    .bodySmall,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(
                                12, 0, 0, 0),
                            child: Text(

                              model.complete!?'${model.expectedDate?.day}/${model.expectedDate?.month}/${model.expectedDate?.year}':'${model.createdAt?.day}/${model.createdAt?.month}/${model.createdAt?.year}',
                              style:
                              FlutterFlowTheme.of(context)
                                  .bodyMedium,
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
          );

      },
    ),
  );
}