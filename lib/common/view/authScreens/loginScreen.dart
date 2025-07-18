import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:katon_taxi25/common/controller/provider/authProvider.dart';
import 'package:katon_taxi25/common/controller/services/mobileAuthServices.dart';
import 'package:katon_taxi25/common/view/authScreens/otpScreen.dart';
import 'package:katon_taxi25/common/widgets/elevatedButtonCommon.dart';
import 'package:katon_taxi25/constant/utils/colors.dart';
import 'package:katon_taxi25/constant/utils/textStyles.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Loginscreen extends StatefulWidget {
  // static const String routeName = "Phone";

  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  login() {
    if (mobileNumberController.text.isNotEmpty) {
      setState(() {
        loginButtonPressed = true;
      });
      context.read<MobileAuthProvider>().updateMobileNumber(
        mobileNumberController.text.trim(),
      );
      // MobileAuthServices.receiveOTP(
      //   context: context,
      //   mobileNumber:
      //       '$selectedCountryCode${mobileNumberController.text.trim()}',
      // );
    }
  }

  TextEditingController mobileNumberController = TextEditingController();
  // String selectedCountryCode = '+964';
  bool loginButtonPressed = false;
  // TextEditingController phonec = TextEditingController();

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5.h),
          Form(
            key: form,
            child: TextFormField(
              autofocus: true,
              validator: (value) {
                const String phonePattern = r'^(?:[+0][1-9])?[0-9]{11}$';
                final regExp = RegExp(phonePattern);
                if (value == null || value.isEmpty) {
                  return "Enter your phone number";
                } else if (!regExp.hasMatch(value)) {
                  return "Enter a correct number";
                }

                return null;
              },
              controller: mobileNumberController,
              maxLength: 13,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "07700000000",
                constraints: BoxConstraints(maxWidth: 400),
                label: Text(
                  "Enter your Phone number ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                //     floatingLabelBehavior: FloatingLabelBehavior.auto,
                // floatingLabelAlignment: FloatingLabelAlignment.center,
                // border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButtonCommon(
            onPressed: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: mobileNumberController.text.trim(),
                verificationCompleted:
                    (PhoneAuthCredential phoneAuthCredential) {},
                verificationFailed: (FirebaseAuthException error) {
                  print(error);
                },
                codeSent: (String verificationId, int? forceResendingToken) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OTPScreen(verifyId: verificationId),
                    ),
                  );
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );

              if (form.currentState!.validate()) {}
              // login();
            },
            backgroundColor: black,
            height: 6.h,
            width: 97.w,
            child: loginButtonPressed == true
                ? CircularProgressIndicator(color: white)
                : Text(
                    'Continue',
                    style: AppTextStyles.small12Bold.copyWith(color: white),
                  ),
          ),
          SizedBox(height: 2.h),

          Text(
            'By proceeding, you consent to get calls, WhatsApp or SMS messages, including by automated means, from Uber and its affiliates to the number provided. ',
            style: AppTextStyles.small10.copyWith(color: grey),
          ),
          SizedBox(height: 3.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'This site is protected by reCAPTHA and the Google ',
                  style: AppTextStyles.small10.copyWith(color: grey),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: AppTextStyles.small10.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(
                  text: ' and ',
                  style: AppTextStyles.small10.copyWith(color: grey),
                ),
                TextSpan(
                  text: 'Terms of Service',
                  style: AppTextStyles.small10.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(
                  text: ' apply',
                  style: AppTextStyles.small10.copyWith(color: grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
