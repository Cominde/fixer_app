import 'package:fixer_app/cubit/cubit.dart';
import 'package:fixer_app/models/get_services_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'services_details_model.dart';
export 'services_details_model.dart';

class ServicesDetails extends StatefulWidget {
  final Visit visit;
  final AppCubit cubit;
   const ServicesDetails({
     super.key,
     required this.visit,
     required this.cubit,
  });

  @override
  State<ServicesDetails> createState() => _ServicesDetailsState();
}

class _ServicesDetailsState extends State<ServicesDetails>
    with TickerProviderStateMixin {
  late ServicesDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 70),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0.95, 0),
          end: const Offset(1, 1),
        ),
      ],
    ),
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 70),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0.9, 0),
          end: const Offset(1, 1),
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 80),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0.9, 0),
          end: const Offset(1, 1),
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 90),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0.9, 0),
          end: const Offset(1, 1),
        ),
      ],
    ),
    'containerOnPageLoadAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 100),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0.9, 0),
          end: const Offset(1, 1),
        ),
      ],
    ),
    'containerOnPageLoadAnimation5': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 110),
          end: const Offset(0, 0),
        ),
      ],
    ),
  };

  late  pw.Document pdf;
  late Uint8List pdfBytes;
  bool isLoading = false;

  int totalServices = 0;
  int totalComponents = 0;
  int totalAdditions = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ServicesDetailsModel());
    if(widget.visit.services.isNotEmpty) {
      totalServices = widget.visit.services.map((service) => service.price).reduce((a, b) => a! + b!)??0;
    }

    if(widget.visit.components.isNotEmpty) {
      totalComponents = widget.visit.components.map((component) => component.price).reduce((a, b) => a! + b!)??0;
    }

    if(widget.visit.additions.isNotEmpty) {
      totalAdditions = widget.visit.additions.map((addition) => addition.price).reduce((a, b) => a! + b!)??0;
    }

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void buildPdf() {
    setState(() {
      isLoading = true;
    });

    pdf = pw.Document();

    rootBundle.load('assets/images/logo.png').then((value) {
      pw.MemoryImage image = pw.MemoryImage(value.buffer.asUint8List());

      rootBundle.load("assets/fonts/Hacen_Tunisia/Hacen-Tunisia.ttf").then((value) {
        pw.Font myFont = pw.Font.ttf(value);

        pdf.addPage(pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Expanded(
                  child: pw.Container(
                      child: pw.Stack(
                          children: [
                            pw.Padding(
                                padding: const pw.EdgeInsets.all(0),
                                child: pw.Expanded(
                                    child: pw.Column(
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        mainAxisSize: pw.MainAxisSize.max,
                                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                                        children: [
                                          pw.Row(
                                            mainAxisSize: pw.MainAxisSize.max,
                                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Expanded(
                                                  flex: 2,
                                                  child: pw.SizedBox(
                                                      width: 160,
                                                      height: 90,
                                                      child: pw.Image(image)
                                                  ),
                                              ),
                                              pw.Expanded(
                                                  flex: 3,
                                                  child: pw.Column(
                                                      mainAxisAlignment: pw.MainAxisAlignment.center,
                                                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                                                      mainAxisSize: pw.MainAxisSize.max,
                                                      children: [
                                                        pw.SizedBox(
                                                          height: 25
                                                        ),
                                                        boldText(
                                                            'بيان اسعار',myFont
                                                        ),
                                                        pw.Container(
                                                          color: const PdfColor(0.90196,0.90196,0.90196),
                                                          child: pw.Row(
                                                              mainAxisAlignment: pw.MainAxisAlignment.center,
                                                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                                                              mainAxisSize: pw.MainAxisSize.max,
                                                              children: [
                                                                boldText(
                                                                  '***',myFont
                                                                ),
                                                              ]
                                                          ),
                                                        ),
                                                      ]
                                                  ),
                                              ),
                                              pw.Expanded(
                                                flex: 2,
                                                child: pw.Column(
                                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                                                    mainAxisSize: pw.MainAxisSize.max,
                                                    children: [
                                                      pw.SizedBox(
                                                        height: 70
                                                      ),
                                                      pw.Row(
                                                         mainAxisAlignment: pw.MainAxisAlignment.end,
                                                         crossAxisAlignment: pw.CrossAxisAlignment.center,
                                                         mainAxisSize: pw.MainAxisSize.max,
                                                        children: [
                                                          pw.SizedBox(
                                                            width: 70,
                                                            child: pw.Table(
                                                                border: pw.TableBorder.all(
                                                                    width: 1,
                                                                    color: PdfColor.fromHex('000000')
                                                                ),
                                                                children: [
                                                                  pw.TableRow(
                                                                      children: [
                                                                        normalText(
                                                                            '${widget.visit.createdAt?.year}-${widget.visit.createdAt?.month}-${widget.visit.createdAt?.day}',myFont
                                                                        ),
                                                                      ]
                                                                  ),
                                                                  pw.TableRow(
                                                                      children: [
                                                                        normalText(
                                                                            '${widget.visit.expectedDate?.year}-${widget.visit.expectedDate?.month}-${widget.visit.expectedDate?.day}',myFont
                                                                        ),
                                                                      ]
                                                                  ),
                                                                ]
                                                            ),
                                                          ),
                                                          pw.Table(
                                                              children: [
                                                                pw.TableRow(
                                                                    children: [
                                                                      boldText(
                                                                          'تاريخ الدخول',myFont
                                                                      ),
                                                                    ]
                                                                ),
                                                                pw.TableRow(
                                                                    children: [
                                                                      boldText(
                                                                          'تاريخ الخروج',myFont
                                                                      ),
                                                                    ]
                                                                ),
                                                              ]
                                                          ),

                                                        ]
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            ]
                                          ),
                                          pw.SizedBox(
                                            height: 2
                                          ),
                                          pw.Container(
                                            width: double.infinity,
                                            height: 2,
                                            color: const PdfColor(0,0,0)
                                          ),
                                          pw.SizedBox(
                                              height: 4,
                                          ),
                                          pw.Row(
                                              children: [
                                                pw.Expanded(
                                                    flex: 2,
                                                    child: pw.Table(
                                                        border: pw.TableBorder.all(
                                                            width: 1,
                                                            color: PdfColor.fromHex('000000')
                                                        ),
                                                        children: [
                                                          pw.TableRow(
                                                              children: [
                                                                normalText(
                                                                    '***',myFont
                                                                ),
                                                              ]
                                                          ),
                                                          pw.TableRow(
                                                              children: [
                                                                normalText(
                                                                    widget.cubit.loginByCodeModel?.userData?.phone??'***',myFont
                                                                ),
                                                              ]
                                                          ),
                                                          pw.TableRow(
                                                              children: [
                                                                normalText(
                                                                    widget.cubit.loginByCodeModel?.carData?.model??'***' ,myFont
                                                                ),
                                                              ]
                                                          ),
                                                          pw.TableRow(
                                                              children: [
                                                                normalText(
                                                                    widget.cubit.loginByCodeModel?.carData?.generatedCode??'***' ,myFont
                                                                ),
                                                              ]
                                                          ),
                                                        ]
                                                    ),
                                                ),
                                                pw.Expanded(
                                                  flex: 1,
                                                  child: pw.Table(
                                                      children: [
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'اسم المندوب :',myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'تليفون :',myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'موديل :' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'كود السيارة :' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                                pw.SizedBox(
                                                  width: 10
                                                ),
                                                pw.Expanded(
                                                  flex: 1,
                                                  child: pw.Table(
                                                      border: pw.TableBorder.all(
                                                          width: 1,
                                                          color: PdfColor.fromHex('000000')
                                                      ),
                                                      children: [
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  widget.cubit.loginByCodeModel?.userData?.name??'***' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  widget.cubit.loginByCodeModel?.carData?.carIdNumber??'***' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  widget.cubit.loginByCodeModel?.carData?.brand??'***' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  widget.cubit.loginByCodeModel?.carData?.distance.toString()??'***' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                                pw.Expanded(
                                                  flex: 1,
                                                  child: pw.Table(
                                                      children: [
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'اسم العميل :',myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'رقم الشاسيه :',myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'نوع العربية :' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'كيلومتر :' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                                pw.SizedBox(
                                                    width: 10
                                                ),
                                                pw.Expanded(
                                                  flex: 1,
                                                  child: pw.Table(
                                                      border: pw.TableBorder.all(
                                                          width: 1,
                                                          color: PdfColor.fromHex('000000')
                                                      ),
                                                      children: [
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  '***' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  widget.cubit.loginByCodeModel?.carData?.carNumber??'***' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  '***' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  widget.cubit.loginByCodeModel?.carData?.color??'***' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                                pw.Expanded(
                                                  flex: 1,
                                                  child: pw.Table(
                                                      children: [
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'رقم امر التشغيل :',myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'رقم اللوحة :',myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'مهندس الاستقبال :' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                        pw.TableRow(
                                                            children: [
                                                              normalText(
                                                                  'اللون :' ,myFont
                                                              ),
                                                            ]
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                              ]
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Center(
                                            child: boldText(
                                                'قطع غيار + اعمال خارجية',myFont
                                            ),
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Table(
                                              border: pw.TableBorder.all(
                                                  width: 1,
                                                  color: PdfColor.fromHex('000000')
                                              ),
                                              children: [
                                                pw.TableRow(
                                                    decoration: pw.BoxDecoration(
                                                        border: pw.TableBorder.all(
                                                            width: 1,
                                                            color: PdfColor.fromHex('000000')
                                                        ),
                                                        color: const PdfColor(0.90196,0.90196,0.90196),
                                                    ),
                                                    children: [
                                                      normalText(
                                                          'القيمة',myFont
                                                      ),
                                                      normalText(
                                                          'السعر',myFont
                                                      ),
                                                      normalText(
                                                          'الكمية',myFont
                                                      ),
                                                      normalText(
                                                          'اسم الصنف',myFont
                                                      ),
                                                    ]
                                                ),
                                                for(int i=0; i<widget.visit.components.length; i++)...[
                                                  pw.TableRow(
                                                      decoration: pw.BoxDecoration(
                                                          border: pw.TableBorder.all(
                                                              width: 1,
                                                              color: PdfColor.fromHex('000000')
                                                          )
                                                      ),
                                                      children: [
                                                        normalText(
                                                            (widget.visit.components[i].price!*widget.visit.components[i].quantity!).toString(),myFont
                                                        ),
                                                        normalText(
                                                            widget.visit.components[i].price.toString(),myFont
                                                        ),
                                                        normalText(
                                                            widget.visit.components[i].quantity.toString(),myFont
                                                        ),
                                                        normalText(
                                                            widget.visit.components[i].name!,myFont
                                                        ),
                                                      ]
                                                  ),
                                                ],
                                                for(int i=0; i<widget.visit.additions.length; i++)...[
                                                  pw.TableRow(
                                                      decoration: pw.BoxDecoration(
                                                          border: pw.TableBorder.all(
                                                              width: 1,
                                                              color: PdfColor.fromHex('000000')
                                                          )
                                                      ),
                                                      children: [
                                                        normalText(
                                                            widget.visit.additions[i].price!.toString(),myFont
                                                        ),
                                                        normalText(
                                                            widget.visit.additions[i].price.toString(),myFont
                                                        ),
                                                        normalText(
                                                            '1',myFont
                                                        ),
                                                        normalText(
                                                            widget.visit.additions[i].name!,myFont
                                                        ),
                                                      ]
                                                  ),
                                                ],
                                              ]
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Center(
                                            child: boldText(
                                                'مصنعات',myFont
                                            ),
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Table(
                                              border: pw.TableBorder.all(
                                                  width: 1,
                                                  color: PdfColor.fromHex('000000')
                                              ),
                                              children: [
                                                pw.TableRow(
                                                    decoration: pw.BoxDecoration(
                                                        border: pw.TableBorder.all(
                                                            width: 1,
                                                            color: PdfColor.fromHex('000000')
                                                        ),
                                                        color: const PdfColor(0.90196,0.90196,0.90196),
                                                    ),
                                                    children: [
                                                      normalText(
                                                          'القيمة',myFont
                                                      ),
                                                      normalText(
                                                          'السعر',myFont
                                                      ),
                                                      normalText(
                                                          'الكمية',myFont
                                                      ),
                                                      normalText(
                                                          'اسم الصنف',myFont
                                                      ),
                                                    ]
                                                ),
                                                for(int i=0; i<widget.visit.services.length; i++)...[
                                                  pw.TableRow(
                                                      decoration: pw.BoxDecoration(
                                                          border: pw.TableBorder.all(
                                                              width: 1,
                                                              color: PdfColor.fromHex('000000')
                                                          )
                                                      ),
                                                      children: [
                                                        normalText(
                                                            widget.visit.services[i].price!.toString(),myFont
                                                        ),
                                                        normalText(
                                                            widget.visit.services[i].price.toString(),myFont
                                                        ),
                                                        normalText(
                                                            '1',myFont
                                                        ),
                                                        normalText(
                                                            widget.visit.services[i].name!,myFont
                                                        ),
                                                      ]
                                                  ),
                                                ],
                                              ]
                                          ),
                                          pw.Expanded(
                                            child: pw.SizedBox(),
                                          ),
                                          pw.Row(
                                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                                            mainAxisSize: pw.MainAxisSize.max,
                                            children: [
                                              pw.Expanded(
                                                child: pw.Table(
                                                    border: pw.TableBorder.all(
                                                        width: 1,
                                                        color: PdfColor.fromHex('000000')
                                                    ),
                                                    children: [
                                                      pw.TableRow(
                                                          decoration: pw.BoxDecoration(
                                                            border: pw.TableBorder.all(
                                                                width: 1,
                                                                color: PdfColor.fromHex('000000')
                                                            ),
                                                          ),
                                                          children: [
                                                            normalText(
                                                                totalServices.toString(),myFont
                                                            ),
                                                            pw.Container(
                                                              color: const PdfColor(0.90196,0.90196,0.90196),
                                                              child: normalText(
                                                                  'صافي المصنعات',myFont
                                                              ),
                                                            ),
                                                          ]
                                                      ),
                                                      pw.TableRow(
                                                          decoration: pw.BoxDecoration(
                                                            border: pw.TableBorder.all(
                                                                width: 1,
                                                                color: PdfColor.fromHex('000000')
                                                            ),
                                                          ),
                                                          children: [
                                                            normalText(
                                                                (totalServices+widget.visit.discount!).toString(),myFont
                                                            ),
                                                            pw.Container(
                                                              color: const PdfColor(0.90196,0.90196,0.90196),
                                                              child: normalText(
                                                                  'صافي المصنعات بعد الخصم',myFont
                                                              ),
                                                            ),
                                                          ]
                                                      ),
                                                      pw.TableRow(
                                                          decoration: pw.BoxDecoration(
                                                            border: pw.TableBorder.all(
                                                                width: 1,
                                                                color: PdfColor.fromHex('000000')
                                                            ),
                                                          ),
                                                          children: [
                                                            normalText(
                                                                totalComponents.toString(),myFont
                                                            ),
                                                            pw.Container(
                                                              color: const PdfColor(0.90196,0.90196,0.90196),
                                                              child: normalText(
                                                                  'صافي القطع غيار',myFont
                                                              ),
                                                            ),
                                                          ]
                                                      ),
                                                    ]
                                                ),
                                              ),
                                              pw.Expanded(
                                                child: pw.SizedBox(),
                                              ),
                                              pw.Expanded(
                                                child: pw.Table(
                                                    border: pw.TableBorder.all(
                                                        width: 1,
                                                        color: PdfColor.fromHex('000000')
                                                    ),
                                                    children: [
                                                      pw.TableRow(
                                                          decoration: pw.BoxDecoration(
                                                            border: pw.TableBorder.all(
                                                                width: 1,
                                                                color: PdfColor.fromHex('000000')
                                                            ),
                                                          ),
                                                          children: [
                                                            normalText(
                                                                (widget.visit.discount!+widget.visit.priceAfterDiscount!).toString(),myFont
                                                            ),
                                                            pw.Container(
                                                              child: normalText(
                                                                  'الاجمالي',myFont
                                                              ),
                                                            ),
                                                          ]
                                                      ),
                                                      pw.TableRow(
                                                          decoration: pw.BoxDecoration(
                                                            border: pw.TableBorder.all(
                                                                width: 1,
                                                                color: PdfColor.fromHex('000000')
                                                            ),
                                                          ),
                                                          children: [
                                                            normalText(
                                                                (widget.visit.priceAfterDiscount!).toString(),myFont
                                                            ),
                                                            pw.Container(
                                                              child: normalText(
                                                                  'الاجمالي بعد الخصم',myFont
                                                              ),
                                                            ),
                                                          ]
                                                      ),
                                                      pw.TableRow(
                                                          decoration: pw.BoxDecoration(
                                                            border: pw.TableBorder.all(
                                                                width: 1,
                                                                color: PdfColor.fromHex('ffffff')
                                                            ),
                                                          ),
                                                          children: [
                                                            normalText(
                                                                widget.visit.discount.toString(),myFont
                                                            ),
                                                            pw.Container(
                                                              color: const PdfColor(0.90196,0.90196,0.90196),
                                                              child: normalText(
                                                                  'خصم',myFont
                                                              ),
                                                            ),
                                                          ]
                                                      ),
                                                      pw.TableRow(
                                                          decoration: pw.BoxDecoration(
                                                            border: pw.TableBorder.all(
                                                                width: 1,
                                                                color: PdfColor.fromHex('ffffff')
                                                            ),
                                                          ),
                                                          children: [
                                                            normalText(
                                                                'نقدي',myFont
                                                            ),
                                                            normalText(
                                                                'دفعات سابقة',myFont
                                                            ),
                                                          ]
                                                      ),
                                                      pw.TableRow(
                                                          decoration: pw.BoxDecoration(
                                                            border: pw.TableBorder.all(
                                                                width: 1,
                                                                color: PdfColor.fromHex('000000')
                                                            ),
                                                            color: const PdfColor(0.90196,0.90196,0.90196),
                                                          ),
                                                          children: [
                                                            normalText(
                                                                widget.visit.priceAfterDiscount.toString(),myFont
                                                            ),
                                                            normalText(
                                                                '0',myFont
                                                            ),
                                                          ]
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            ]
                                          ),
                                          pw.SizedBox(
                                            height: 10,
                                          ),
                                          pw.Container(
                                            width: double.infinity,
                                            height: 50,
                                            color: const PdfColor(0.90196,0.90196,0.90196),
                                            child: pw.Row(
                                              mainAxisSize: pw.MainAxisSize.max,
                                              children: [
                                                pw.Expanded(
                                                  child: pw.Container(
                                                    height: 50,
                                                    decoration: pw.BoxDecoration(
                                                      border: pw.TableBorder.all(
                                                          width: 1,
                                                          color: PdfColor.fromHex('000000')
                                                      ),
                                                      color: const PdfColor(1,1,1),
                                                    ),
                                                  )
                                                ),
                                                boldText('اعمال هامة لم تتم بالسيارة', myFont),
                                              ]
                                            )
                                          ),
                                          pw.Row(
                                              mainAxisSize: pw.MainAxisSize.max,
                                              mainAxisAlignment: pw.MainAxisAlignment.end,
                                              children: [
                                                pw.Padding(
                                                  padding: const pw.EdgeInsets.symmetric(horizontal: 10,vertical: 25),
                                                  child: pw.Column(
                                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                                    children: [
                                                      boldText('توقيع العميل', myFont),
                                                      normalText('.........................................' , myFont)
                                                    ]
                                                  )
                                                )
                                              ]
                                          ),
                                          pw.Row(
                                              mainAxisSize: pw.MainAxisSize.max,
                                              mainAxisAlignment: pw.MainAxisAlignment.start,
                                              children: [
                                                pw.Column(
                                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Row(
                                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                                        children: [
                                                          boldText('Email: ', myFont),
                                                          normalText('fixerservicecenter@gmail.com' , myFont)
                                                        ]
                                                    ),
                                                    pw.Row(
                                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                                        children: [
                                                          boldText('Address: ', myFont),
                                                          normalText('117 St. Teraat Al Gabal - Hadaik el Quiba' , myFont)
                                                        ]
                                                    ),
                                                  ]
                                                ),
                                              ]
                                          )
                                        ]
                                    )
                                )
                            )
                          ]
                      )
                  )
              ); // Center
            }));

        pdf.save().then((value) {
          pdfBytes = value;
          setState(() {
            isLoading = false;
          });
        });// Page

      });
    });
  }

  pw.Padding boldText (String s, pw.Font myFont) {
    return pw.Padding(
        padding: const pw.EdgeInsets.all(3),
        child: pw.Center(child: pw.Directionality(child: pw.Text(s, style: pw.TextStyle(fontWeight: pw.FontWeight.bold,font: myFont,fontSize: 10)),textDirection: pw.TextDirection.rtl))
    );
  }

  pw.Padding normalText (String s, pw.Font myFont) {
    return pw.Padding(
        padding: const pw.EdgeInsets.all(3),
        child: pw.Center(child: pw.Directionality(child: pw.Text(s, style: pw.TextStyle(font: myFont,fontSize: 8)),textDirection: pw.TextDirection.rtl))
    );
  }

  Future<void> printArabicPdf (pw.Document pdf) async{
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            actions: const [],
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 14),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              borderWidth: 1,
                              buttonSize: 50,
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 30,
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(4, 0, 16, 0),
                              child: Text(
                                '#${widget.visit.id}',

                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              expandedTitleScale: 1.0,
            ),
            elevation: 0,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x2B202529),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Image.asset(
                                  'assets/images/41723171321.png',
                                  width: double.infinity,
                                  height: 210,
                                  fit: BoxFit.cover,
                                ).animateOnPageLoad(
                                    animationsMap['imageOnPageLoadAnimation']!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Car Number: ${widget.visit.carNumber}",
                            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Service Type: ${widget.visit.type}",
                            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Expected Date: ${widget.visit.expectedDate?.day}/${widget.visit.expectedDate?.month}/${widget.visit.expectedDate?.year}",
                            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Services:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: widget.visit.services.map((service) {
                              return ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(service.name!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                ),
                                subtitle: Text("${service.price} EGP",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                trailing: Text(service.state!,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: service.state! == 'repairing'?const Color(0xFFF68B1E):FlutterFlowTheme.of(context).success),),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Additions:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: widget.visit.additions.map((addition) {
                              return ListTile(
                                title: Text(addition.name!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                subtitle: Text("${addition.price} EGP",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Components:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: widget.visit.components.map((component) {
                              return ListTile(
                                title: Text(component.name!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                subtitle: Text(
                                    "${component.price} EGP",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                trailing: Text(
                                  "x ${component.quantity}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xFFF68B1E)),),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Price After Discount: ${widget.visit.priceAfterDiscount} EGP",
                            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Completion Ratio: ${widget.visit.completedServicesRatio} %",
                            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                          /*SizedBox(height: 16),
                          Text(
                            "State: ${widget.visit.state}",
                            style: TextStyle(fontSize: 18),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                buildPdf();
                await printArabicPdf(pdf);
              },
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF68B1E),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x411D2429),
                      offset: Offset(0, -2),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                  child: isLoading?const SpinKitDualRing(
                    color: Colors.white,
                    size: 30,
                  ):
                  Text(
                    'Bill',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
