import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:katon_taxi25/common/controller/provider/authProvider.dart';
import 'package:katon_taxi25/common/controller/services/mobileAuthServices.dart';
import 'package:katon_taxi25/common/view/registrationScreen/registrationScreen.dart';
import 'package:katon_taxi25/common/view/signInLogic/signInLogin.dart';
import 'package:katon_taxi25/common/widgets/elevatedButtonCommon.dart';
import 'package:katon_taxi25/constant/utils/colors.dart';
import 'package:katon_taxi25/constant/utils/textStyles.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.verifyId});
  final String verifyId;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isLoding = false;
  int num = 60;
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  decreaseNum() {
    if (num > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          num = num - 1;
        });
        decreaseNum();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      decreaseNum();
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   otpController.dispose();
  // }

  bool loginButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 1.w),
          child: ElevatedButtonCommon(
            onPressed: () async {
              try {
                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verifyId,
                  smsCode: otpController.text,
                );

                await FirebaseAuth.instance.signInWithCredential(credential);

                Navigator.push(
                  context,
                  PageTransition(
                    child: const RegistrationScreen(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              } catch (e) {
                print('Error during sign-in: $e');
              }
            },
            backgroundColor: black,
            height: 6.h,
            width: 100.w,

            child: loginButtonPressed == true
                ? CircularProgressIndicator(color: white)
                : Text(
                    'Continue',
                    style: AppTextStyles.small12Bold.copyWith(color: white),
                  ),
          ),
        ),

        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            Text('Welcome', style: AppTextStyles.body18),
            SizedBox(height: 2.h),
            Text(
              'Enter the 6-digit code sent to you at ${context.read<MobileAuthProvider>().mobileNumber}',
              style: AppTextStyles.small10,
            ),
            SizedBox(height: 4.h),
            PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              textStyle: AppTextStyles.body14,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5.sp),
                fieldHeight: 50,
                fieldWidth: 50,
                activeFillColor: black,
                inactiveColor: black,
                inactiveFillColor: blue50,
                selectedFillColor: white,
                selectedColor: black,
                activeColor: black,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: transparent,
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: otpController,
              onCompleted: (value) {
                //!!!!!!!!!!!!!!!!!!
                MobileAuthServices.verifyOTP(
                  context: context,
                  otp: otpController.text.trim(),
                );
              },
              onChanged: (value) {},
              beforeTextPaste: (text) {
                return true;
              },
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.sp),
                      color: greyShade3,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 0.5.h,
                    ),
                    child: Text(
                      num > 0
                          ? 'I didn\'t receive a code (00:$num)'
                          : 'I didn\'t receive a code',
                      style: AppTextStyles.small10.copyWith(
                        color: num > 1 ? blue : red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
