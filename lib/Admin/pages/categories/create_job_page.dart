import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedma/Admin/pages/jobs/controller/jobs_controller.dart';
import 'package:khedma/Admin/pages/jobs/models/job_model.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/utils.dart';

// ignore: must_be_immutable
class AdminCreateJob extends StatefulWidget {
  const AdminCreateJob({super.key, this.jobToEdit});
  final JobModel? jobToEdit;
  @override
  State<AdminCreateJob> createState() => _AdminCreateJobState();
}

class _AdminCreateJobState extends State<AdminCreateJob> {
  String button1Text = "upload_job_icon".tr;
  JobModel jobToCreate = JobModel();
  JobsController _jobsController = Get.find();
  String? selectedValue;
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];
  @override
  void initState() {
    if (widget.jobToEdit != null) {
      button1Text = widget.jobToEdit!.icon
          .toString()
          .substring(widget.jobToEdit!.icon.toString().lastIndexOf("/") + 1);
    }
    for (var i in _focusNodes) {
      i.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: coloredText(
            text: widget.jobToEdit != null ? "edit".tr : "create_job".tr,
            fontSize: 15.0.sp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          primary: false,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            coloredText(text: "name_ar".tr),
            spaceY(5.sp),
            SendMessageTextField(
              initialValue:
                  widget.jobToEdit != null ? widget.jobToEdit!.nameAr : null,
              focusNode: _focusNodes[0],
              borderRadius: 10,
              onchanged: (s) {
                if (widget.jobToEdit != null) {
                  widget.jobToEdit!.nameAr = s;
                } else {
                  jobToCreate.nameAr = s;
                }
              },
            ),
            spaceY(10.sp),
            coloredText(text: "name_en".tr),
            spaceY(5.sp),
            SendMessageTextField(
              initialValue:
                  widget.jobToEdit != null ? widget.jobToEdit!.nameEn : null,
              focusNode: _focusNodes[1],
              onchanged: (s) {
                if (widget.jobToEdit != null) {
                  widget.jobToEdit!.nameEn = s;
                } else {
                  jobToCreate.nameEn = s;
                }
              },
              borderRadius: 10,
            ),
            spaceY(20.sp),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: GestureDetector(
                onTap: () async {
                  XFile? image = await Utils().selectImageSheet();

                  if (image != null) {
                    setState(() {});

                    button1Text =
                        image.name.substring(0, min(15, image.name.length));
                    if (widget.jobToEdit != null) {
                      widget.jobToEdit!.icon = image;
                    } else {
                      jobToCreate.icon = image;
                    }
                    setState(() {});
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.13),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.upload,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 13.0.sp,
                      ),
                      spaceX(10.0.sp),
                      coloredText(
                          text: button1Text,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 13.0.sp)
                    ],
                  ),
                ),
              ),
            ),
            spaceY(10.0.h),
            primaryButton(
                onTap: () async {
                  bool b = false;
                  FocusScope.of(context).unfocus();
                  if (widget.jobToEdit != null) {
                    b = await _jobsController.updateJob(job: widget.jobToEdit!);
                    logSuccess("edit");
                  } else {
                    b = await _jobsController.createJob(job: jobToCreate);
                    logSuccess("create");
                  }
                  if (b) Utils.doneDialog(context: context, backTimes: 2);
                },
                width: 80.0.w,
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ]),
                text: coloredText(
                  text: "apply".tr,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
