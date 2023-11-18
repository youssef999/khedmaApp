import 'package:email_validator/email_validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Pages/log-reg%20pages/forget%20password/check_email.dart';
import 'package:khedma/Pages/log-reg%20pages/forget%20password/controller/password_controller.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:khedma/widgets/dropdown_menu_button.dart';
import 'package:khedma/widgets/underline_text_field.dart';
import 'package:sizer/sizer.dart';

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool phoneEmailFlag = false;
  String phoneCode = "";
  final PasswordController _passwordController = Get.find();

  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];
  @override
  void initState() {
    for (var node in _focusNodes) {
      node.addListener(() {
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
        title: coloredText(text: "reset_password".tr, fontSize: 15.0.sp),
      ),
      body: ListView(
        primary: false,
        padding: EdgeInsets.all(20),
        children: [
          coloredText(
              text: phoneEmailFlag
                  ? "write_your_ph_num".tr
                  : "write_your_email".tr,
              fontSize: 14.sp),
          spaceY(10.sp),
          Form(
            key: formKey,
            child: phoneEmailFlag
                ? SendMessageTextField(
                    borderRadius: 10,
                    focusNode: _focusNodes[0],
                    controller: _phoneNumberController,
                    keyBoardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.always,
                    onchanged: (s) {},
                    validator: (String? value) {
                      if (value!.length < 7 && value.isNotEmpty) {
                        return "phone must be 7 numbers at least";
                      }
                      return null;
                    },
                    prefixIcon: Container(
                      margin: const EdgeInsetsDirectional.only(start: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            EvaIcons.phoneOutline,
                            size: 20.0.sp,
                          ),
                          GetBuilder<GlobalController>(builder: (c) {
                            return CustomDropDownMenuButton(
                              width: 65.sp,
                              hintPadding: 5,
                              contentPadding: 10,
                              hintSize: 13,
                              value: phoneCode == "" ? null : phoneCode,
                              items: c.countries
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e.code!,
                                        child: coloredText(
                                          text: e.code!,
                                          fontSize: 17,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (s) {
                                phoneCode = s!;
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    hintText: "phone_number".tr,
                    // validator: (String? value) =>
                    //     EmailValidator.validate(value!)
                    //         ? null
                    //         : "please_enter_a_valid_email".tr,
                  )
                : SendMessageTextField(
                    borderRadius: 10,
                    focusNode: _focusNodes[1],
                    padding: const EdgeInsets.all(0),
                    keyBoardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    textDirection: TextDirection.ltr,
                    validator: (s) {
                      if (!EmailValidator.validate(s!)) {
                        return "please_enter_a_valid_email".tr;
                      } else if (s.isEmpty) {
                        return "can't be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
          ),
          spaceY(20),
          primaryButton(
            text: coloredText(
              text: "next".tr,
              color: Colors.white,
              fontSize: 13.sp,
            ),
            width: 75.w,
            color: Theme.of(context).colorScheme.primary,
            onTap: () async {
              if (formKey.currentState!.validate()) {
                bool b = await _passwordController.forgetPassWord(
                    sender: emailController.text, type: phoneEmailFlag ? 1 : 2);
                if (b) {
                  Get.to(() => CheckEmailPage(
                      phoneEmailFlag: phoneEmailFlag,
                      sender: emailController.text));
                }
              }
            },
          ),
          spaceY(20),
          Align(
            child: GestureDetector(
              onTap: () {
                phoneEmailFlag = !phoneEmailFlag;
                emailController.text = "";
                _phoneNumberController.text = "";
                phoneCode = "";
                _focusNodes[0].unfocus();
                _focusNodes[1].unfocus();
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )),
                child: coloredText(
                    text: phoneEmailFlag ? "try_email".tr : "try_ph_num".tr,
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          )
        ],
      ),
    );
  }
}
