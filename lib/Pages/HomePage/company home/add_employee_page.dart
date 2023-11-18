import 'dart:async';
import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:khedma/Admin/pages/jobs/models/job_model.dart';
import 'package:khedma/Admin/pages/languages/models/language_model.dart';
import 'package:khedma/Pages/HomePage/company%20home/models/employee_model.dart';
import 'package:khedma/Pages/HomePage/controllers/employees_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Themes/themes.dart';
import 'package:khedma/widgets/radio_button.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:line_icons/line_icons.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:translator/translator.dart';

import '../../../Utils/utils.dart';
import '../../../widgets/dropdown_menu_button.dart';

// ignore: must_be_immutable
class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key, this.employeeToEdit});
  final EmployeeModel? employeeToEdit;

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  String passportButton = "upload_your_passport".tr;
  Debouncer _de = Debouncer();
  var errors = {};
  String? imageToEdit;
  String nationality = "";
  String religion = "";
  String birthplace = "";
  String livingTown = "";
  String maritalStatus = "";
  String complexion = "";
  String issuePlace = "";
  // String contractDuration = "";
  String workAbroad = "yes".tr;
  String educationalCertificate = "";

  List<JobModel> jobs = [];
  List<JobModel> selectedJobs = [];
  List<LanguageModel> langs = [];
  List<LanguageModel> selectedLangs = [];
  final EmployeesController _employeesController = Get.find();
  int offerRadio = 0;
  String appLanguage = "en";
  final List<FocusNode> _focusNodes = List.generate(24, (index) => FocusNode());

  final GlobalController _globalController = Get.find();
  String imagePath = "";
  String passportPath = "";
  Widget? imageWidget = Icon(
    EvaIcons.person,
    size: 35.w,
    color: Colors.white,
  );
  @override
  void initState() {
    jobs = List.from(_globalController.jobs);
    langs = _globalController.languages;
    _globalController.getAppLanguage().then((value) {
      setState(() {
        appLanguage = value;
      });
    });

    initFormIfEdit();
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  final imageDataKey = GlobalKey();
  final dataKey = GlobalKey();
  final dataKey2 = GlobalKey();
  final dataKey3 = GlobalKey();
  final dataKey4 = GlobalKey();

  final ExpandableController _expandableController =
      ExpandableController(initialExpanded: true);
  final ExpandableController _expandable2Controller =
      ExpandableController(initialExpanded: false);
  final ExpandableController _expandable3Controller =
      ExpandableController(initialExpanded: false);
  final ExpandableController _expandable4Controller =
      ExpandableController(initialExpanded: false);
  final TextEditingController _fullNameArController = TextEditingController();
  final TextEditingController _fullNameEnController = TextEditingController();
  final TextEditingController _employmentDurationController =
      TextEditingController();
  final TextEditingController _amountAfterDiscountController =
      TextEditingController();
  final TextEditingController _childrenNumController = TextEditingController();
  final TextEditingController _contractAmountController =
      TextEditingController();
  final TextEditingController _contractDurationController =
      TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _monthlySaleryController =
      TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _expirydateController = TextEditingController();
  final TextEditingController _issuedateController = TextEditingController();
  final TextEditingController _passportNoController = TextEditingController();
  final TextEditingController _descEditingController = TextEditingController();
  // final TextEditingController _monthlySaleryController =
  //     TextEditingController();
  // final TextEditingController _hourlySaleryController = TextEditingController();
  // final TextEditingController _timeToWorkPerDayController =
  //     TextEditingController();

  EmployeeModel employeeToCreate = EmployeeModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: coloredText(
            text: widget.employeeToEdit != null ? "edit".tr : "add_employee".tr,
            fontSize: 15.0.sp),
      ),
      body: ExpandableNotifier(
        child: ExpandableTheme(
          data: const ExpandableThemeData(
            iconColor: Colors.black,
            useInkWell: false,
          ),
          child: GetBuilder<GlobalController>(builder: (c) {
            return Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceY(8.sp),
                    GestureDetector(
                      key: imageDataKey,
                      onTap: () async {
                        XFile? image = await Utils().selectImageSheet();

                        if (image != null) {
                          imageWidget = null;
                          imageToEdit = null;
                          imagePath = image.path;
                          if (widget.employeeToEdit != null) {
                            widget.employeeToEdit!.image = image;
                          } else {
                            employeeToCreate.image = image;
                          }

                          setState(() {});
                        }
                      },
                      child: Stack(
                        children: [
                          Align(
                            child: Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xffEFEFEF),
                                image: imageToEdit != null
                                    ? DecorationImage(
                                        image: NetworkImage(imageToEdit!),
                                        fit: BoxFit.cover,
                                      )
                                    : imageWidget != null
                                        ? null
                                        : DecorationImage(
                                            image: FileImage(
                                              File(imagePath),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                              ),
                              child: imageWidget,
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 0,
                            end: 23.w,
                            child: Align(
                              child: Container(
                                width: 15.w,
                                height: 15.w,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 4),
                                  shape: BoxShape.circle,
                                  color: const Color(0xffEFEFEF),
                                ),
                                child: Icon(
                                  EvaIcons.plus,
                                  size: 10.w,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    spaceY(8.sp),
                    Container(
                      key: dataKey,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Color(0xffEFEFEF)),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ExpandablePanel(
                        controller: _expandableController,
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToCollapse: true,
                        ),
                        header: Padding(
                          padding: const EdgeInsets.all(10),
                          child: coloredText(
                            text: "personal_info".tr,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        collapsed: Container(),
                        expanded: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: Color(0xffEFEFEF)),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  spaceY(10),
                                  coloredText(text: "name_en".tr),
                                  spaceY(5.sp),
                                  SendMessageTextField(
                                    borderRadius: 10,
                                    focusNode: _focusNodes[23],
                                    fillColor: const Color(0xffF8F8F8),
                                    controller: _fullNameEnController,
                                    onchanged: (s) {
                                      _de.run(() {
                                        if (s != null && s != "") {
                                          final translator = GoogleTranslator();
                                          translator
                                              .translate(s,
                                                  from: 'en', to: 'ar')
                                              .then((value) {
                                            _fullNameArController.text =
                                                value.text;
                                            if (widget.employeeToEdit != null) {
                                              widget.employeeToEdit!.nameAr =
                                                  value.text;
                                            } else {
                                              employeeToCreate.nameAr =
                                                  value.text;
                                            }
                                            setState(() {});
                                          });
                                        }
                                        if (s == "") {
                                          _fullNameArController.text = "";
                                          if (widget.employeeToEdit != null) {
                                            widget.employeeToEdit!.nameAr =
                                                null;
                                          } else {
                                            employeeToCreate.nameAr = null;
                                          }
                                          setState(() {});
                                        }
                                        //perform search here
                                      });

                                      if (widget.employeeToEdit != null) {
                                        widget.employeeToEdit!.nameEn = s;
                                      } else {
                                        employeeToCreate.nameEn = s;
                                      }
                                    },
                                    validator: (s) {
                                      if (errors['name_en'] != null) {
                                        String tmp = "";
                                        tmp = errors['name_en'].join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "name_ar".tr),
                                  spaceY(5.sp),
                                  SendMessageTextField(
                                    borderRadius: 10,
                                    focusNode: _focusNodes[0],
                                    fillColor: const Color(0xffF8F8F8),
                                    controller: _fullNameArController,
                                    onchanged: (s) {
                                      if (widget.employeeToEdit != null) {
                                        widget.employeeToEdit!.nameAr = s;
                                      } else {
                                        employeeToCreate.nameAr = s;
                                      }
                                    },
                                    validator: (s) {
                                      if (errors['name_ar'] != null) {
                                        String tmp = "";
                                        tmp = errors['name_ar'].join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "nationality".tr),
                                  spaceY(5.sp),
                                  SearchableDropDownV2(
                                    height: 40.sp,
                                    hintPadding: 0,

                                    // padding: const EdgeInsetsDirectional.only(
                                    //     start: 10),
                                    focusNode: _focusNodes[1],

                                    // borderc: Border.all(color: Colors.red),
                                    fillColor: const Color(0xffF8F8F8),
                                    filled: true,

                                    width: 100.w,

                                    value:
                                        nationality == "" ? null : nationality,
                                    items: c.countries
                                        .map((e) => DropDownValueModel(
                                              value: Get.locale ==
                                                      const Locale('en', 'US')
                                                  ? e.nameEn!
                                                  : e.nameAr,
                                              name: Get.locale ==
                                                      const Locale('en', 'US')
                                                  ? e.nameEn!
                                                  : e.nameAr!,
                                            ))
                                        .toList(),

                                    onChanged: (p0) {
                                      DropDownValueModel d = p0;
                                      nationality = d.name;
                                      if (widget.employeeToEdit != null) {
                                        widget.employeeToEdit!.nationalityId = c
                                            .countries
                                            .lastWhere((element) =>
                                                element.nameAr == d.name ||
                                                element.nameEn == d.name)
                                            .id;
                                      } else {
                                        employeeToCreate.nationalityId = c
                                            .countries
                                            .lastWhere((element) =>
                                                element.nameAr == d.name ||
                                                element.nameEn == d.name)
                                            .id;
                                      }

                                      setState(() {});
                                    },

                                    validator: (s) {
                                      if (errors['nationality_id'] != null) {
                                        String tmp = "";
                                        tmp =
                                            errors['nationality_id'].join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },

                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 10,
                                    borderc:
                                        Border.all(color: Colors.transparent),

                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "religion".tr),
                                  spaceY(5.sp),
                                  CustomDropDownMenuButtonV2(
                                    hintPadding: 0,
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10),
                                    focusNode: _focusNodes[2],
                                    fillColor: const Color(0xffF8F8F8),
                                    filled: true,
                                    width: 100.w,
                                    value: religion == "" ? null : religion,
                                    items: c.relegions
                                        .map(
                                          (e) => DropdownMenuItem<String>(
                                            value: Get.locale ==
                                                    const Locale('en', 'US')
                                                ? e.nameEn!
                                                : e.nameAr!,
                                            child: coloredText(
                                                text: Get.locale ==
                                                        const Locale('en', 'US')
                                                    ? e.nameEn!
                                                    : e.nameAr!,
                                                color: Colors.black),
                                          ),
                                        )
                                        .toList(),
                                    border: null,
                                    onChanged: (p0) {
                                      religion = p0!;
                                      if (widget.employeeToEdit != null) {
                                        widget.employeeToEdit!.religionId = c
                                            .relegions
                                            .lastWhere((element) =>
                                                element.nameAr == p0 ||
                                                element.nameEn == p0)
                                            .id;
                                      } else {
                                        employeeToCreate.religionId = c
                                            .relegions
                                            .lastWhere((element) =>
                                                element.nameAr == p0 ||
                                                element.nameEn == p0)
                                            .id;
                                      }

                                      setState(() {});
                                    },
                                    validator: (s) {
                                      if (errors['religion_id'] != null) {
                                        String tmp = "";
                                        tmp = errors['religion_id'].join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    borderRadius: 10,
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "date_of_birth".tr),
                                  spaceY(5.sp),
                                  SendMessageTextField(
                                    onTap: () async {
                                      DateTime? x = await showDatePicker(
                                        builder: (context, child) => Theme(
                                          data: ThemeData(
                                            colorScheme: ColorScheme.fromSeed(
                                              seedColor: AppThemes.colorCustom,
                                            ),
                                          ),
                                          child: child!,
                                        ),
                                        context: context,
                                        initialDate: DateTime.now().subtract(
                                            const Duration(days: 365 * 19)),
                                        firstDate: DateTime.now().subtract(
                                            const Duration(days: 365 * 100)),
                                        lastDate: DateTime.now().subtract(
                                            const Duration(days: 365 * 18)),
                                      );
                                      if (x != null) {
                                        _dateController.text =
                                            DateFormat('y/MM/dd').format(x);
                                      }
                                    },
                                    focusNode: _focusNodes[3],
                                    hintText: 'YYYY/MM/DD',
                                    fillColor: const Color(0xffF8F8F8),
                                    borderRadius: 10,
                                    controller: _dateController,
                                    readOnly: true,
                                    validator: (s) {
                                      if (errors['date_of_birth'] != null) {
                                        String tmp = "";
                                        tmp =
                                            errors['date_of_birth'].join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    onchanged: (s) {},
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "birth_place".tr),
                                  spaceY(5.sp),
                                  SearchableDropDownV2(
                                    height: 40.sp,
                                    hintPadding: 0,
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10),
                                    focusNode: _focusNodes[4],

                                    // borderc: Border.all(color: Colors.red),
                                    fillColor: const Color(0xffF8F8F8),
                                    filled: true,
                                    width: 100.w,
                                    value: birthplace == "" ? null : birthplace,
                                    items: c.countries
                                        .map((e) => DropDownValueModel(
                                              value: Get.locale ==
                                                      const Locale('en', 'US')
                                                  ? e.nameEn!
                                                  : e.nameAr,
                                              name: Get.locale ==
                                                      const Locale('en', 'US')
                                                  ? e.nameEn!
                                                  : e.nameAr!,
                                            ))
                                        .toList(),
                                    border: null,
                                    validator: (s) {
                                      if (errors['birth_place'] != null) {
                                        String tmp = "";
                                        tmp = errors['birth_place'].join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    onChanged: (p0) {
                                      DropDownValueModel d = p0;
                                      birthplace = d.name;

                                      setState(() {});
                                      if (widget.employeeToEdit != null) {
                                        widget.employeeToEdit!.birthPlace = c
                                            .countries
                                            .lastWhere((element) =>
                                                element.nameAr == d.name ||
                                                element.nameEn == d.name)
                                            .id;
                                      } else {
                                        employeeToCreate.birthPlace = c
                                            .countries
                                            .lastWhere((element) =>
                                                element.nameAr == d.name ||
                                                element.nameEn == d.name)
                                            .id;
                                      }

                                      setState(() {});
                                    },

                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 10,
                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "living_town".tr),
                                  spaceY(5.sp),
                                  SearchableDropDownV2(
                                    height: 40.sp,
                                    hintPadding: 0,
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10),
                                    focusNode: _focusNodes[5],

                                    fillColor: const Color(0xffF8F8F8),
                                    filled: true,
                                    width: 100.w,
                                    value: livingTown == "" ? null : livingTown,
                                    items: c.countries
                                        .map((e) => DropDownValueModel(
                                              value: Get.locale ==
                                                      const Locale('en', 'US')
                                                  ? e.nameEn!
                                                  : e.nameAr,
                                              name: Get.locale ==
                                                      const Locale('en', 'US')
                                                  ? e.nameEn!
                                                  : e.nameAr!,
                                            ))
                                        .toList(),
                                    border: null,
                                    validator: (s) {
                                      if (errors['living_town'] != null) {
                                        String tmp = "";
                                        tmp = errors['living_town'].join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    onChanged: (p0) {
                                      DropDownValueModel d = p0;
                                      livingTown = d.name;

                                      setState(() {});
                                      if (widget.employeeToEdit != null) {
                                        widget.employeeToEdit!.livingTown = c
                                            .countries
                                            .lastWhere((element) =>
                                                element.nameAr == d.name ||
                                                element.nameEn == d.name)
                                            .id;
                                      } else {
                                        employeeToCreate.livingTown = c
                                            .countries
                                            .lastWhere((element) =>
                                                element.nameAr == d.name ||
                                                element.nameEn == d.name)
                                            .id;
                                      }

                                      setState(() {});
                                    },

                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 10,
                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "marital_status".tr),
                                  spaceY(5.sp),
                                  CustomDropDownMenuButtonV2(
                                    hintPadding: 0,
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10),
                                    focusNode: _focusNodes[6],

                                    // borderc: Border.all(color: Colors.red),
                                    fillColor: const Color(0xffF8F8F8),
                                    filled: true,
                                    width: 100.w,
                                    value: maritalStatus == ""
                                        ? null
                                        : maritalStatus,
                                    items: c.maritalStatusList
                                        .map(
                                          (e) => DropdownMenuItem<String>(
                                            value: Get.locale ==
                                                    const Locale('en', 'US')
                                                ? e.nameEn!
                                                : e.nameAr!,
                                            child: coloredText(
                                                text: Get.locale ==
                                                        const Locale('en', 'US')
                                                    ? e.nameEn!
                                                    : e.nameAr!,
                                                color: Colors.black),
                                          ),
                                        )
                                        .toList(),
                                    border: null,
                                    validator: (s) {
                                      if (errors['marital_status'] != null) {
                                        String tmp = "";
                                        tmp =
                                            errors['marital_status'].join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    onChanged: (p0) {
                                      maritalStatus = p0!;

                                      setState(() {});
                                      if (widget.employeeToEdit != null) {
                                        widget.employeeToEdit!.maritalStatus = c
                                            .maritalStatusList
                                            .lastWhere((element) =>
                                                element.nameAr == p0 ||
                                                element.nameEn == p0)
                                            .id;
                                      } else {
                                        employeeToCreate.maritalStatus = c
                                            .maritalStatusList
                                            .lastWhere((element) =>
                                                element.nameAr == p0 ||
                                                element.nameEn == p0)
                                            .id;
                                      }

                                      setState(() {});
                                    },

                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 10,
                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "no_of_children".tr),
                                  spaceY(5.sp),
                                  SendMessageTextField(
                                    focusNode: _focusNodes[7],

                                    controller: _childrenNumController,
                                    keyBoardType: TextInputType.number,
                                    fillColor: const Color(0xffF8F8F8),

                                    width: 100.w,

                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 8,
                                    validator: (s) {
                                      if (errors['num_of_children'] != null) {
                                        String tmp = "";
                                        tmp = errors['num_of_children']
                                            .join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    onchanged: (p0) {
                                      if (p0 != "") {
                                        if (widget.employeeToEdit != null) {
                                          widget.employeeToEdit!.numOfChildren =
                                              int.parse(p0!);
                                        } else {
                                          employeeToCreate.numOfChildren =
                                              int.parse(p0!);
                                        }
                                      }
                                      setState(() {});
                                    },
                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  spaceY(10.sp),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            coloredText(text: "weight".tr),
                                            SizedBox(
                                              width: 40.w,
                                              child: SendMessageTextField(
                                                suffixIcon:
                                                    Utils.kwdSuffix("kg"),

                                                focusNode: _focusNodes[8],
                                                controller: _weightController,
                                                keyBoardType:
                                                    TextInputType.number,
                                                fillColor:
                                                    const Color(0xffF8F8F8),
                                                width: 100.w,

                                                // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                                borderRadius: 8,
                                                validator: (s) {
                                                  if (errors['weight'] !=
                                                      null) {
                                                    String tmp = "";
                                                    tmp = errors['weight']
                                                        .join("\n");

                                                    return tmp;
                                                  }
                                                  return null;
                                                },
                                                onchanged: (s) {
                                                  if (s != "") {
                                                    if (widget.employeeToEdit !=
                                                        null) {
                                                      widget.employeeToEdit!
                                                              .weight =
                                                          int.parse(s!);
                                                    } else {
                                                      employeeToCreate.weight =
                                                          int.parse(s!);
                                                    }
                                                  }
                                                },
                                                // padding:
                                                //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                              ),
                                            ),
                                          ]),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            coloredText(text: "height".tr),
                                            SizedBox(
                                              width: 40.w,
                                              child: SendMessageTextField(
                                                suffixIcon:
                                                    Utils.kwdSuffix("cm"),
                                                focusNode: _focusNodes[9],
                                                controller: _heightController,
                                                keyBoardType:
                                                    TextInputType.number,
                                                fillColor:
                                                    const Color(0xffF8F8F8),
                                                width: 100.w,

                                                // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                                borderRadius: 8,
                                                validator: (s) {
                                                  if (errors['hight'] != null) {
                                                    String tmp = "";
                                                    tmp = errors['hight']
                                                        .join("\n");

                                                    return tmp;
                                                  }
                                                  return null;
                                                },
                                                onchanged: (s) {
                                                  setState(() {});
                                                  if (s != "") {
                                                    setState(() {});
                                                    if (widget.employeeToEdit !=
                                                        null) {
                                                      widget.employeeToEdit!
                                                              .hight =
                                                          int.parse(s!);
                                                    } else {
                                                      employeeToCreate.hight =
                                                          int.parse(s!);
                                                    }
                                                  }
                                                },
                                                // padding:
                                                //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                              ),
                                            ),
                                          ]),
                                    ],
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "complexion".tr),
                                  spaceY(5.sp),
                                  CustomDropDownMenuButtonV2(
                                    hintPadding: 0,
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10),
                                    focusNode: _focusNodes[10],

                                    // borderc: Border.all(color: Colors.red),
                                    fillColor: const Color(0xffF8F8F8),
                                    filled: true,
                                    width: 100.w,
                                    value: complexion == "" ? null : complexion,
                                    items: c.complexionList
                                        .map(
                                          (e) => DropdownMenuItem<String>(
                                            value: Get.locale ==
                                                    const Locale('en', 'US')
                                                ? e.nameEn!
                                                : e.nameAr!,
                                            child: coloredText(
                                                text: Get.locale ==
                                                        const Locale('en', 'US')
                                                    ? e.nameEn!
                                                    : e.nameAr!,
                                                color: Colors.black),
                                          ),
                                        )
                                        .toList(),
                                    border: null,
                                    validator: (s) {
                                      if (errors['complexion_id'] != null) {
                                        String tmp = "";
                                        tmp =
                                            errors['complexion_id'].join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    onChanged: (p0) {
                                      complexion = p0!;

                                      setState(() {});
                                      if (widget.employeeToEdit != null) {
                                        widget.employeeToEdit!.complexionId = c
                                            .complexionList
                                            .lastWhere((element) =>
                                                element.nameAr == p0 ||
                                                element.nameEn == p0)
                                            .id;
                                      } else {
                                        employeeToCreate.complexionId = c
                                            .complexionList
                                            .lastWhere((element) =>
                                                element.nameAr == p0 ||
                                                element.nameEn == p0)
                                            .id;
                                      }

                                      setState(() {});
                                    },

                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 10,
                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  spaceY(10.sp),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    spaceY(10.sp),
                    Container(
                      key: dataKey2,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Color(0xffEFEFEF)),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ExpandablePanel(
                        controller: _expandable2Controller,
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToCollapse: true,
                        ),
                        header: Padding(
                          padding: const EdgeInsets.all(10),
                          child: coloredText(
                            text: "passport_data".tr,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        collapsed: Container(),
                        expanded: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: Color(0xffEFEFEF)),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  spaceY(10),
                                  coloredText(text: "passport_number".tr),
                                  spaceY(5.sp),
                                  SendMessageTextField(
                                    borderRadius: 10,
                                    focusNode: _focusNodes[11],
                                    fillColor: const Color(0xffF8F8F8),
                                    controller: _passportNoController,
                                    validator: (s) {
                                      if (errors['passport_num'] != null) {
                                        String tmp = "";
                                        tmp = errors['passport_num'].join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    onchanged: (s) {
                                      if (s != "") {
                                        if (widget.employeeToEdit != null) {
                                          widget.employeeToEdit!.passportNum =
                                              s!;
                                        } else {
                                          employeeToCreate.passportNum = s!;
                                        }
                                      }
                                    },
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "issue_date".tr),
                                  spaceY(5.sp),
                                  SendMessageTextField(
                                    onTap: () async {
                                      DateTime? x = await showDatePicker(
                                        builder: (context, child) => Theme(
                                          data: ThemeData(
                                            colorScheme: ColorScheme.fromSeed(
                                              seedColor: AppThemes.colorCustom,
                                            ),
                                          ),
                                          child: child!,
                                        ),
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now().subtract(
                                            const Duration(days: 365 * 100)),
                                        lastDate: DateTime.now(),
                                      );
                                      if (x != null) {
                                        _issuedateController.text =
                                            DateFormat('y/MM/dd').format(x);
                                      }
                                    },
                                    focusNode: _focusNodes[12],
                                    hintText: 'YYYY/MM/DD',
                                    fillColor: const Color(0xffF8F8F8),
                                    borderRadius: 10,
                                    controller: _issuedateController,
                                    readOnly: true,
                                    validator: (s) {
                                      if (errors['passport_issue_date'] !=
                                          null) {
                                        String tmp = "";
                                        tmp = errors['passport_issue_date']
                                            .join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "issue_place".tr),
                                  spaceY(5.sp),
                                  SearchableDropDownV2(
                                    height: 40.sp,
                                    hintPadding: 0,
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10),
                                    focusNode: _focusNodes[13],
                                    validator: (s) {
                                      if (errors['passport_place_of_issue'] !=
                                          null) {
                                        String tmp = "";
                                        tmp = errors['passport_place_of_issue']
                                            .join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    // borderc: Border.all(color: Colors.red),
                                    fillColor: const Color(0xffF8F8F8),
                                    filled: true,
                                    width: 100.w,
                                    value: issuePlace == "" ? null : issuePlace,
                                    items: c.countries
                                        .map((e) => DropDownValueModel(
                                              value: Get.locale ==
                                                      const Locale('en', 'US')
                                                  ? e.nameEn!
                                                  : e.nameAr,
                                              name: Get.locale ==
                                                      const Locale('en', 'US')
                                                  ? e.nameEn!
                                                  : e.nameAr!,
                                            ))
                                        .toList(),
                                    border: null,

                                    onChanged: (p0) {
                                      DropDownValueModel d = p0;
                                      issuePlace = d.name;
                                      if (widget.employeeToEdit != null) {
                                        widget.employeeToEdit!
                                                .passportPlaceOfIssue =
                                            c.countries
                                                .lastWhere((element) =>
                                                    element.nameAr == d.name ||
                                                    element.nameEn == d.name)
                                                .id;
                                      } else {
                                        employeeToCreate.passportPlaceOfIssue =
                                            c.countries
                                                .lastWhere((element) =>
                                                    element.nameAr == d.name ||
                                                    element.nameEn == d.name)
                                                .id;
                                      }

                                      setState(() {});
                                    },
                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 10,
                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "expiry_date".tr),
                                  spaceY(5.sp),
                                  SendMessageTextField(
                                    onTap: () async {
                                      DateTime? x = await showDatePicker(
                                        builder: (context, child) => Theme(
                                          data: ThemeData(
                                            colorScheme: ColorScheme.fromSeed(
                                              seedColor: AppThemes.colorCustom,
                                            ),
                                          ),
                                          child: child!,
                                        ),
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now().subtract(
                                            const Duration(days: 365 * 100)),
                                        lastDate: DateTime.now().add(
                                            const Duration(days: 365 * 100)),
                                      );
                                      if (x != null) {
                                        _expirydateController.text =
                                            DateFormat('y/MM/dd').format(x);
                                      }
                                    },
                                    focusNode: _focusNodes[14],
                                    hintText: 'YYYY/MM/DD',
                                    fillColor: const Color(0xffF8F8F8),
                                    borderRadius: 10,
                                    controller: _expirydateController,
                                    readOnly: true,
                                    validator: (s) {
                                      if (errors['passport_expiry_date'] !=
                                          null) {
                                        String tmp = "";
                                        tmp = errors['passport_expiry_date']
                                            .join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                  ),
                                  spaceY(20.sp),
                                  primaryButton(
                                      onTap: () async {
                                        XFile? image =
                                            await Utils().selectImageSheet();

                                        if (image != null) {
                                          passportButton = image.name;
                                          passportPath = image.path;
                                          if (widget.employeeToEdit != null) {
                                            widget.employeeToEdit!
                                                .passportImege = image;
                                          } else {
                                            employeeToCreate.passportImege =
                                                image;
                                          }

                                          setState(() {});
                                        }
                                      },
                                      color: const Color(0xffF5F5F5),
                                      width: 100.0.w,
                                      height: 55,
                                      radius: 10,
                                      text: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              spaceX(10),
                                              Icon(
                                                LineIcons.passport,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                size: 18.0.sp,
                                              ),
                                              spaceX(10),
                                              coloredText(
                                                text: passportButton,
                                                color: const Color(0xff919191),
                                                fontSize: 13.0.sp,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                size: 20.0.sp,
                                              ),
                                              spaceX(10),
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    spaceY(10.sp),
                    Container(
                      key: dataKey3,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Color(0xffEFEFEF)),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ExpandablePanel(
                        controller: _expandable3Controller,
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToCollapse: true,
                        ),
                        header: Padding(
                          padding: const EdgeInsets.all(10),
                          child: coloredText(
                            text: "work_info".tr,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        collapsed: Container(),
                        expanded: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: Color(0xffEFEFEF)),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  spaceY(10),
                                  coloredText(text: "job".tr),
                                  spaceY(5.sp),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      dialogTheme: DialogTheme(
                                        backgroundColor: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        elevation: 5,
                                        shadowColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: const BorderSide(
                                              color: Colors.grey, width: 0.5),
                                        ),
                                      ),
                                    ),
                                    child: MultiSelectDialogField(
                                      validator: (s) {
                                        if (errors['jobs'] != null) {
                                          String tmp = "";
                                          tmp = errors['jobs'].join("\n");

                                          return tmp;
                                        }
                                        return null;
                                      },
                                      cancelText: coloredText(
                                        text: "cancel".tr,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      confirmText: coloredText(
                                        text: "ok".tr,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      title: coloredText(
                                          text: "select".tr,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16.sp),
                                      buttonText: coloredText(
                                          text: "choose".tr,
                                          color: Colors.grey,
                                          fontSize: 15),
                                      items: jobs
                                          .map(
                                            (e) => MultiSelectItem(
                                              e,
                                              Get.locale ==
                                                      const Locale('en', 'US')
                                                  ? e.nameEn!
                                                  : e.nameAr!,
                                            ),
                                          )
                                          .toList(),
                                      listType: MultiSelectListType.CHIP,
                                      // selectedColor: Theme.of(context).colorScheme.secondary,
                                      // backgroundColor: Colors.white,
                                      selectedItemsTextStyle: coloredText(
                                              text: "text",
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)
                                          .style,
                                      selectedColor: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.05),
                                      onSelectionChanged: (p0) {
                                        selectedJobs = [];
                                        setState(() {});
                                      },
                                      buttonIcon: Icon(
                                        FontAwesomeIcons.sortDown,
                                        color: Colors.grey.shade700,
                                        size: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF8F8F8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      chipDisplay:
                                          MultiSelectChipDisplay<String>.none(),
                                      initialValue: selectedJobs,
                                      onConfirm: (values) {
                                        selectedJobs =
                                            List<JobModel>.from(values);
                                        if (widget.employeeToEdit != null) {
                                          if (selectedJobs.isNotEmpty)
                                            widget.employeeToEdit!.jobs =
                                                selectedJobs;
                                        } else {
                                          employeeToCreate.jobs = selectedJobs;
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  spaceY(5.sp),
                                  selectedJobs.isEmpty
                                      ? Container()
                                      : SizedBox(
                                          height: 28.sp,
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) =>
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 20,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.05),
                                                    ),
                                                    child: Center(
                                                        child: coloredText(
                                                            text: appLanguage ==
                                                                    "en"
                                                                ? selectedJobs[
                                                                        index]
                                                                    .nameEn!
                                                                : selectedJobs[
                                                                        index]
                                                                    .nameAr!,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary)),
                                                  ),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      spaceX(10.sp),
                                              itemCount: selectedJobs.length),
                                        ),
                                  spaceY(10.sp),
                                  coloredText(text: "monthly_salery".tr),
                                  spaceY(5.sp),
                                  SendMessageTextField(
                                    focusNode: _focusNodes[15],
                                    validator: (s) {
                                      if (errors['salary_month'] != null) {
                                        String tmp = "";
                                        tmp = errors['salary_month'].join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    hintText: "0",
                                    suffixIcon: Utils.kwdSuffix("kwd".tr),
                                    controller: _monthlySaleryController,
                                    keyBoardType: TextInputType.number,
                                    fillColor: const Color(0xffF8F8F8),
                                    width: 100.w,
                                    onchanged: (s) {
                                      if (s != "") {
                                        employeeToCreate.salaryMonth = s;
                                      }
                                    },
                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 8,
                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "contract_duration".tr),
                                  spaceY(5.sp),
                                  SendMessageTextField(
                                    suffixIcon: Utils.kwdSuffix("years".tr),

                                    focusNode: _focusNodes[16],
                                    validator: (s) {
                                      if (errors['contract_duration'] != null) {
                                        String tmp = "";
                                        tmp = errors['contract_duration']
                                            .join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    hintText: "0",
                                    controller: _contractDurationController,
                                    keyBoardType: TextInputType.number,
                                    fillColor: const Color(0xffF8F8F8),
                                    width: 100.w,
                                    onchanged: (s) {
                                      if (s != "") {
                                        if (widget.employeeToEdit != null) {
                                          widget.employeeToEdit!
                                              .contractDuration = s;
                                        } else {
                                          employeeToCreate.contractDuration = s;
                                        }
                                      }
                                    },
                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 8,
                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "contract_amount".tr),
                                  SendMessageTextField(
                                    focusNode: _focusNodes[22],
                                    validator: (s) {
                                      if (errors['contract_amount'] != null) {
                                        String tmp = "";
                                        tmp = errors['contract_amount']
                                            .join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    hintText: "0",
                                    suffixIcon: Utils.kwdSuffix("kwd".tr),

                                    controller: _contractAmountController,
                                    keyBoardType: TextInputType.number,
                                    fillColor: const Color(0xffF8F8F8),

                                    width: 100.w,
                                    onchanged: (s) {
                                      if (s != "") {
                                        if (widget.employeeToEdit != null) {
                                          widget.employeeToEdit!
                                              .contractAmount = s;
                                        } else {
                                          employeeToCreate.contractAmount = s;
                                        }
                                      }
                                    },
                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 8,
                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  spaceY(10.sp),
                                  coloredText(text: "is_offer".tr),
                                  Row(
                                    children: [
                                      MyRadioButton(
                                        text: "no".tr,
                                        color: Colors.black,
                                        value: 0,
                                        groupValue: offerRadio,
                                        onChanged: (p0) {
                                          offerRadio = p0;
                                          employeeToCreate.isOffer = p0;
                                          setState(() {});
                                        },
                                      ),
                                      spaceX(20),
                                      MyRadioButton(
                                        text: "yes".tr,
                                        color: Colors.black,
                                        value: 1,
                                        groupValue: offerRadio,
                                        onChanged: (p0) {
                                          offerRadio = p0;
                                          if (widget.employeeToEdit != null) {
                                            widget.employeeToEdit!.isOffer = p0;
                                          } else {
                                            employeeToCreate.isOffer = p0;
                                          }
                                          setState(() {});
                                        },
                                      )
                                    ],
                                  ),
                                  offerRadio == 0 ? Container() : spaceY(5.sp),
                                  offerRadio == 0
                                      ? Container()
                                      : coloredText(
                                          text: "amount_after_disccount".tr),
                                  offerRadio == 0
                                      ? Container()
                                      : SendMessageTextField(
                                          focusNode: _focusNodes[21],
                                          suffixIcon: Utils.kwdSuffix("kwd".tr),

                                          validator: (s) {
                                            if (errors[
                                                    'amount_after_discount'] !=
                                                null) {
                                              String tmp = "";
                                              tmp = errors[
                                                      'amount_after_discount']
                                                  .join("\n");

                                              return tmp;
                                            }
                                            return null;
                                          },
                                          // hintText: "0 KD",
                                          controller:
                                              _amountAfterDiscountController,
                                          keyBoardType: TextInputType.number,
                                          fillColor: const Color(0xffF8F8F8),
                                          width: 100.w,

                                          // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                          borderRadius: 8,
                                          onchanged: (s) {
                                            if (s != "") {
                                              if (widget.employeeToEdit !=
                                                  null) {
                                                widget.employeeToEdit!
                                                        .amountAfterDiscount =
                                                    int.parse(s!);
                                              } else {
                                                employeeToCreate
                                                        .amountAfterDiscount =
                                                    int.parse(s!);
                                              }
                                            }
                                          },
                                        ),
                                  spaceY(10.sp),
                                  coloredText(text: "previous_work_abroad".tr),
                                  spaceY(5.sp),
                                  CustomDropDownMenuButtonV2(
                                    hintPadding: 0,
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10),
                                    focusNode: _focusNodes[17],

                                    validator: (String? value) {
                                      if (value == null) return null;
                                      if (value.isEmpty) return "required".tr;
                                      return null;
                                    },
                                    // borderc: Border.all(color: Colors.red),
                                    fillColor: const Color(0xffF8F8F8),
                                    filled: true,
                                    width: 100.w,
                                    value: workAbroad == "" ? null : workAbroad,
                                    items: ["yes".tr, "no".tr]
                                        .map(
                                          (e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: coloredText(
                                                text: e, color: Colors.black),
                                          ),
                                        )
                                        .toList(),
                                    border: null,

                                    onChanged: (p0) {
                                      workAbroad = p0!;
                                      if (widget.employeeToEdit != null) {
                                        widget.employeeToEdit!
                                                .previousWorkAbroad =
                                            p0 == "no".tr ? 0 : 1;
                                      } else {
                                        employeeToCreate.previousWorkAbroad =
                                            p0 == "no".tr ? 0 : 1;
                                      }
                                      setState(() {});
                                    },

                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 10,
                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  employeeToCreate.previousWorkAbroad == 0
                                      ? Container()
                                      : spaceY(10.sp),
                                  employeeToCreate.previousWorkAbroad == 0
                                      ? Container()
                                      : coloredText(
                                          text: "duration_of_employment".tr),
                                  employeeToCreate.previousWorkAbroad == 0
                                      ? Container()
                                      : spaceY(5.sp),
                                  employeeToCreate.previousWorkAbroad == 0
                                      ? Container()
                                      : SendMessageTextField(
                                          suffixIcon:
                                              Utils.kwdSuffix("years".tr),

                                          focusNode: _focusNodes[18],
                                          validator: (s) {
                                            if (errors[
                                                    'duration_of_employment'] !=
                                                null) {
                                              String tmp = "";
                                              tmp = errors[
                                                      'duration_of_employment']
                                                  .join("\n");

                                              return tmp;
                                            }
                                            return null;
                                          },
                                          // hintText: "0 KD",
                                          controller:
                                              _employmentDurationController,
                                          keyBoardType: TextInputType.number,
                                          fillColor: const Color(0xffF8F8F8),

                                          width: 100.w,

                                          // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                          borderRadius: 8,
                                          onchanged: (s) {
                                            if (s != "") {
                                              if (widget.employeeToEdit !=
                                                  null) {
                                                widget.employeeToEdit!
                                                        .durationOfEmployment =
                                                    int.parse(s!);
                                              } else {
                                                employeeToCreate
                                                        .durationOfEmployment =
                                                    int.parse(s!);
                                              }
                                            }
                                          },
                                          // padding:
                                          //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                        ),
                                  spaceY(10.sp),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    spaceY(10.sp),
                    Container(
                      key: dataKey4,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Color(0xffEFEFEF)),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ExpandablePanel(
                        controller: _expandable4Controller,
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToCollapse: true,
                        ),
                        header: Padding(
                          padding: const EdgeInsets.all(10),
                          child: coloredText(
                            text: "other_data".tr,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        collapsed: Container(),
                        expanded: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: Color(0xffEFEFEF)),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  spaceY(10),
                                  coloredText(
                                      text: "educational_certificates".tr),
                                  spaceY(5.sp),
                                  CustomDropDownMenuButtonV2(
                                    hintPadding: 0,
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10),
                                    focusNode: _focusNodes[19],

                                    validator: (s) {
                                      if (errors['education_certification'] !=
                                          null) {
                                        String tmp = "";
                                        tmp = errors['education_certification']
                                            .join("\n");

                                        return tmp;
                                      }
                                      return null;
                                    },
                                    // borderc: Border.all(color: Colors.red),
                                    fillColor: const Color(0xffF8F8F8),
                                    filled: true,
                                    width: 100.w,
                                    value: educationalCertificate == ""
                                        ? null
                                        : educationalCertificate,
                                    items: c.certificates
                                        .map(
                                          (e) => DropdownMenuItem<String>(
                                            value: Get.locale ==
                                                    const Locale('en', 'US')
                                                ? e.nameEn!
                                                : e.nameAr!,
                                            child: coloredText(
                                                text: Get.locale ==
                                                        const Locale('en', 'US')
                                                    ? e.nameEn!
                                                    : e.nameAr!,
                                                color: Colors.black),
                                          ),
                                        )
                                        .toList(),
                                    border: null,

                                    onChanged: (p0) {
                                      educationalCertificate = p0!;
                                      if (widget.employeeToEdit != null) {
                                        widget.employeeToEdit!
                                                .educationCertification =
                                            c.certificates
                                                .lastWhere((element) =>
                                                    element.nameAr == p0 ||
                                                    element.nameEn == p0)
                                                .id;
                                      } else {
                                        employeeToCreate
                                                .educationCertification =
                                            c.certificates
                                                .lastWhere((element) =>
                                                    element.nameAr == p0 ||
                                                    element.nameEn == p0)
                                                .id;
                                      }

                                      setState(() {});
                                    },
                                    // borderc: Border.all(color: const Color(0xffE3E3E3)),
                                    borderRadius: 10,
                                    // padding:
                                    //     const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                  ),
                                  spaceY(10.sp),
                                  coloredText(
                                      text: "knowledge_of_languages".tr),
                                  spaceY(5.sp),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      dialogTheme: DialogTheme(
                                        backgroundColor: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        elevation: 5,
                                        shadowColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: const BorderSide(
                                              color: Colors.grey, width: 0.5),
                                        ),
                                      ),
                                    ),
                                    child: MultiSelectDialogField(
                                      validator: (s) {
                                        if (errors['languages'] != null) {
                                          String tmp = "";
                                          tmp = errors['languages'].join("\n");

                                          return tmp;
                                        }
                                        return null;
                                      },
                                      onSelectionChanged: (p0) {
                                        selectedLangs = [];
                                        setState(() {});
                                      },
                                      cancelText: coloredText(
                                        text: "cancel".tr,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      confirmText: coloredText(
                                        text: "ok".tr,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      title: coloredText(
                                          text: "select".tr,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16.sp),
                                      buttonText: coloredText(
                                          text: "choose".tr,
                                          color: Colors.grey,
                                          fontSize: 15),
                                      items: langs
                                          .map(
                                            (e) => MultiSelectItem(
                                              e,
                                              Get.locale ==
                                                      const Locale('en', 'US')
                                                  ? e.nameEn!
                                                  : e.nameAr!,
                                            ),
                                          )
                                          .toList(),
                                      listType: MultiSelectListType.CHIP,
                                      // selectedColor: Theme.of(context).colorScheme.secondary,
                                      // backgroundColor: Colors.white,
                                      selectedItemsTextStyle: coloredText(
                                              text: "text",
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)
                                          .style,
                                      selectedColor: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.05),

                                      buttonIcon: Icon(
                                        FontAwesomeIcons.sortDown,
                                        color: Colors.grey.shade700,
                                        size: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF8F8F8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      chipDisplay:
                                          MultiSelectChipDisplay<String>.none(),
                                      initialValue: selectedLangs,
                                      onConfirm: (values) {
                                        selectedLangs =
                                            List<LanguageModel>.from(values);
                                        if (widget.employeeToEdit != null) {
                                          if (selectedLangs.isNotEmpty)
                                            widget.employeeToEdit!.languages =
                                                selectedLangs;
                                        } else {
                                          employeeToCreate.languages =
                                              selectedLangs;
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  spaceY(5.sp),
                                  selectedLangs.isEmpty
                                      ? Container()
                                      : SizedBox(
                                          height: 28.sp,
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) =>
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 20,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.05),
                                                    ),
                                                    child: Center(
                                                        child: coloredText(
                                                            text: appLanguage ==
                                                                    "en"
                                                                ? selectedLangs[
                                                                        index]
                                                                    .nameEn!
                                                                : selectedLangs[
                                                                        index]
                                                                    .nameAr!,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary)),
                                                  ),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      spaceX(10.sp),
                                              itemCount: selectedLangs.length),
                                        ),
                                  spaceY(10.sp),
                                  coloredText(text: "more_details".tr),
                                  spaceY(5.sp),
                                  SizedBox(
                                    height: 20.h,
                                    child: TextFormField(
                                      maxLines: 6,
                                      controller: _descEditingController,
                                      onChanged: (value) {
                                        if (widget.employeeToEdit != null) {
                                          widget.employeeToEdit!.desc = value;
                                        } else {
                                          employeeToCreate.desc = value;
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        // hintText: "write_your_notes".tr,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xffF8F8F8),
                                      ),
                                    ),
                                  ),
                                  spaceY(10.sp),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    spaceY(10.sp),
                    primaryButton(
                        onTap: () async {
                          if (widget.employeeToEdit != null) {
                            widget.employeeToEdit!.dateOfBirth =
                                _dateController.text;
                            widget.employeeToEdit!.passportIssueDate =
                                _issuedateController.text;
                            widget.employeeToEdit!.passportExpiryDate =
                                _expirydateController.text;
                            widget.employeeToEdit!.isOffer ??= 0;
                            widget.employeeToEdit!.previousWorkAbroad ??= 1;
                          } else {
                            employeeToCreate.dateOfBirth = _dateController.text;
                            employeeToCreate.passportIssueDate =
                                _issuedateController.text;
                            employeeToCreate.passportExpiryDate =
                                _expirydateController.text;
                            employeeToCreate.isOffer ??= 0;
                            employeeToCreate.previousWorkAbroad ??= 1;
                          }
                          errors = {};
                          formKey.currentState!.validate();
                          var x;
                          if (widget.employeeToEdit != null) {
                            x = await _employeesController.updateEmployee(
                                employee: widget.employeeToEdit!);
                          } else {
                            x = await _employeesController.createEmployee(
                                employee: employeeToCreate);
                          }
                          if (x == true) {
                            // ignore: use_build_context_synchronously
                            Utils.customDialog(
                                actions: [
                                  primaryButton(
                                    onTap: () {
                                      Get.back();
                                      Get.back();
                                      Get.back();
                                    },
                                    width: 40.0.w,
                                    height: 50,
                                    radius: 10.w,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    text: coloredText(
                                      text: "ok".tr,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                                context: context,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      spaceY(20),
                                      Icon(
                                        EvaIcons.checkmarkCircle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 40.sp,
                                      ),
                                      spaceY(20),
                                      coloredText(
                                          text: widget.employeeToEdit != null
                                              ? "done".tr
                                              : "employee_added".tr,
                                          fontSize: 12.0.sp),
                                      coloredText(
                                        text: "successfully".tr,
                                        fontSize: 14.0.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ],
                                  ),
                                ));
                          } else if (x['message'] ==
                              "The given data was invalid.") {
                            errors = x['errors'];
                            setState(() {});
                            if (errors['name_en'] != null ||
                                errors['name_ar'] != null ||
                                errors['date_of_birth'] != null ||
                                errors['hight'] != null ||
                                errors['weight'] != null ||
                                errors['marital_status'] != null ||
                                errors['religion_id'] != null ||
                                errors['complexion_id'] != null ||
                                errors['nationality_id'] != null ||
                                errors['birth_place'] != null ||
                                errors['num_of_children'] != null ||
                                errors['living_town'] != null) {
                              logError("x");
                              if (!_expandableController.expanded) {
                                _expandableController.toggle();
                              }
                              Scrollable.ensureVisible(dataKey.currentContext!);
                            } else if (errors['passport_num'] != null ||
                                errors['passport_issue_date'] != null ||
                                errors['passport_expiry_date'] != null ||
                                errors['passport_place_of_issue'] != null) {
                              if (!_expandable2Controller.expanded) {
                                _expandable2Controller.toggle();
                              }
                              Scrollable.ensureVisible(
                                  dataKey2.currentContext!);
                            } else if (
                                // errors['salary_month'] != null ||
                                errors['contract_amount'] != null ||
                                    errors['contract_duration'] != null ||
                                    errors['jobs'] != null ||
                                    errors['previous_work_abroad'] != null ||
                                    errors['amount_after_discount'] != null) {
                              if (!_expandable3Controller.expanded) {
                                _expandable3Controller.toggle();
                              }
                              Scrollable.ensureVisible(
                                  dataKey3.currentContext!);
                            } else if (errors['languages'] != null ||
                                errors['education_certification'] != null) {
                              if (!_expandable4Controller.expanded) {
                                _expandable4Controller.toggle();
                              }
                              Scrollable.ensureVisible(
                                  dataKey4.currentContext!);
                            } else if (errors['image'] != null) {
                              Utils.showSnackBar(
                                  message: errors['image'].join("\n"),
                                  fontSize: 12.0.sp);
                              Scrollable.ensureVisible(
                                  imageDataKey.currentContext!);
                            } else if (errors['passport_image'] != null) {
                              Utils.showSnackBar(
                                  message: errors['passport_image'].join("\n"),
                                  fontSize: 12.0.sp);
                              if (!_expandable2Controller.expanded) {
                                _expandable2Controller.toggle();
                              }
                              Scrollable.ensureVisible(
                                  dataKey2.currentContext!);
                            }
                          }
                        },
                        width: 40.w,
                        color: Theme.of(context).colorScheme.primary,
                        height: 35.sp,
                        radius: 10.w,
                        text: coloredText(
                            text: widget.employeeToEdit != null
                                ? "edit".tr
                                : "add".tr,
                            color: Colors.white,
                            fontSize: 14.sp)),
                    spaceY(10.sp),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  initFormIfEdit() {
    if (widget.employeeToEdit != null) {
      // selectedJobs = List.from(widget.employeeToEdit!.jobs!);
      // selectedLangs = List.from(widget.employeeToEdit!.languages!);
      _dateController.text = DateFormat('y/MM/dd')
          .format(DateTime.parse(widget.employeeToEdit!.dateOfBirth!));
      _issuedateController.text = DateFormat('y/MM/dd')
          .format(DateTime.parse(widget.employeeToEdit!.passportIssueDate!));
      _expirydateController.text = DateFormat('y/MM/dd')
          .format(DateTime.parse(widget.employeeToEdit!.passportExpiryDate!));
      _fullNameArController.text = widget.employeeToEdit!.nameAr!;
      _fullNameEnController.text = widget.employeeToEdit!.nameEn!;

      passportButton = "passport.png";
      imageToEdit = widget.employeeToEdit!.image!;
      imageWidget = null;
      _passportNoController.text = widget.employeeToEdit!.passportNum!;
      if (widget.employeeToEdit!.isOffer == 1) {
        _amountAfterDiscountController.text =
            widget.employeeToEdit!.amountAfterDiscount!.toString();
      }
      _employmentDurationController.text =
          widget.employeeToEdit!.durationOfEmployment!.toString();
      _contractAmountController.text = widget.employeeToEdit!.contractAmount!;
      _contractDurationController.text =
          widget.employeeToEdit!.contractDuration!;
      _heightController.text = widget.employeeToEdit!.weight!.toString();
      _weightController.text = widget.employeeToEdit!.hight!.toString();
      _childrenNumController.text =
          widget.employeeToEdit!.numOfChildren!.toString();
      nationality = _globalController.countries
          .where(
              (element) => element.id == widget.employeeToEdit!.nationalityId)
          .map((e) =>
              Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
          .first;
      religion = _globalController.relegions
          .where((element) => element.id == widget.employeeToEdit!.religionId)
          .map((e) =>
              Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
          .first;
      birthplace = _globalController.countries
          .where((element) => element.id == widget.employeeToEdit!.birthPlace)
          .map((e) =>
              Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
          .first;
      livingTown = _globalController.countries
          .where((element) => element.id == widget.employeeToEdit!.livingTown)
          .map((e) =>
              Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
          .first;
      maritalStatus = _globalController.maritalStatusList
          .where(
              (element) => element.id == widget.employeeToEdit!.maritalStatus)
          .map((e) =>
              Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
          .first;
      complexion = _globalController.complexionList
          .where((element) => element.id == widget.employeeToEdit!.complexionId)
          .map((e) =>
              Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
          .first;
      issuePlace = _globalController.countries
          .where((element) =>
              element.id == widget.employeeToEdit!.passportPlaceOfIssue)
          .map((e) =>
              Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
          .first;

      workAbroad =
          widget.employeeToEdit!.previousWorkAbroad == 1 ? "yes".tr : 'no'.tr;
      educationalCertificate = _globalController.certificates
          .where((element) =>
              element.id == widget.employeeToEdit!.educationCertification)
          .map((e) =>
              Get.locale == const Locale('en', 'US') ? e.nameEn! : e.nameAr!)
          .first;
    }
  }
}

class Debouncer {
  final int milliseconds;

  Timer? _timer;

  Debouncer({this.milliseconds = 500});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
