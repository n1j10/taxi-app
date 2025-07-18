import 'package:flutter/material.dart';
import 'package:katon_taxi25/common/controller/services/mobileAuthServices.dart';
import 'package:katon_taxi25/constant/utils/colors.dart';

class SignInLogic extends StatefulWidget {
  const SignInLogic({super.key});

  @override
  State<SignInLogic> createState() => _SignInLogicState();
}

class _SignInLogicState extends State<SignInLogic> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        MobileAuthServices.checkAuthenticationAndNavigate(context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: const Center(
        child: Image(image: AssetImage('assets/images/uberLogo/uber.png')),
      ),
    );
  }
}
