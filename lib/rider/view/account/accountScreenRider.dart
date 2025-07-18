import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:katon_taxi25/common/controller/provider/profileDataProvider.dart';
import 'package:katon_taxi25/common/controller/services/mobileAuthServices.dart';
import 'package:katon_taxi25/constant/utils/colors.dart';
import 'package:katon_taxi25/constant/utils/textStyles.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Accountscreenrider extends StatefulWidget {
  const Accountscreenrider({super.key});

  @override
  State<Accountscreenrider> createState() => _AccountscreenriderState();
}

class _AccountscreenriderState extends State<Accountscreenrider> {
  List accountTopButtons = [
    [CupertinoIcons.shield_fill, 'Help'],
    [CupertinoIcons.creditcard_fill, 'Payment'],
    [CupertinoIcons.square_list_fill, 'Activity'],
  ];
  List accountButtons = [
    [CupertinoIcons.gear_alt_fill, 'Settings'],
    [CupertinoIcons.power, 'Logout'],
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProfileDataProvider>().getProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Top Row
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              children: [
                //  Profile Data
                Consumer<ProfileDataProvider>(
                  builder: (context, profileProvider, child) {
                    if (profileProvider.profileData == null) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 70.w,
                            child: Text(
                              'User',
                              style: AppTextStyles.heading26Bold,
                            ),
                          ),
                          Container(
                            height: 16.w,
                            width: 16.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: black87),
                              color: black,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/uberLogo/uber.png',
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          SizedBox(
                            width: 70.w,
                            child: Text(
                              profileProvider.profileData!.name!,
                              style: AppTextStyles.heading26Bold,
                            ),
                          ),
                          Container(
                            height: 16.w,
                            width: 16.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: black87),
                              color: black,
                              image: DecorationImage(
                                image: NetworkImage(
                                  profileProvider.profileData!.profilePicUrl!,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),

                SizedBox(height: 3.h),
                // Top Row Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: accountTopButtons
                      .map(
                        (e) => Container(
                          height: 10.h,
                          width: 28.w,
                          decoration: BoxDecoration(
                            color: greyShade3,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(e[0], size: 4.h, color: black87),
                              SizedBox(height: 1.h),
                              Text(e[1], style: AppTextStyles.small10),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),

            Divider(color: greyShade2, thickness: 0.5.h),
            SizedBox(height: 2.h),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: accountButtons.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (index == (accountButtons.length - 1)) {
                      MobileAuthServices.signOut(context);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      children: [
                        Icon(accountButtons[index][0], color: black, size: 3.h),
                        SizedBox(width: 7.w),
                        Text(
                          accountButtons[index][1],
                          style: AppTextStyles.small12,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
