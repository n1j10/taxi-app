import 'package:flutter/material.dart';
import 'package:katon_taxi25/constant/utils/colors.dart';
import 'package:katon_taxi25/constant/utils/textStyles.dart';
import 'package:katon_taxi25/rider/controller/services/rideRequestServices/rideRequestServices.dart';
import 'package:katon_taxi25/rider/view/selectPickupAndDropLocationScreen/selectPickupAndDropLocationScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({super.key});

  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  //!ride history
  @override
  // void initState() {
  //   super.initState();
  //   RideRequestServices.getRideHistory(context);
  // }
  List moreWaysToUber = [
    [
      'assets/images/moreWaysUber/sendAPackage.png',
      'Send a package',
      'On-demand delivery across town',
    ],
    [
      'assets/images/moreWaysUber/premierTrips.png',
      'Premier trips',
      'Top-rated drivers, newer cars',
    ],
    [
      'assets/images/moreWaysUber/safetyToolKit.png',
      'Safety Toolkit',
      'On-trip help with safety issues',
    ],
  ];
  List planYourNextTrip = [
    [
      'assets/images/planNextTrip/travelIntercity.png',
      'Travel intercity',
      'Get to remote locations with ease',
    ],
    [
      'assets/images/planNextTrip/rentals.png',
      'Rentals',
      'Travel from 1 to 12 hours',
    ],
  ];
  List saveEveryDay = [
    [
      'assets/images/saveEveryDay/uberMotoTrips.png',
      'Uber Moto trips',
      'Affordable motorcycle pick-ups',
    ],
    [
      'assets/images/saveEveryDay/tryAGroupTrip.png',
      'Try a group trip',
      'Seamless trips, together',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Uber', style: AppTextStyles.heading20Bold)),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          //  Where To button
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const PickupAndDropLocationScreen(),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.sp),
                color: greyShade3,
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: black87, size: 4.h),
                  SizedBox(width: 5.w),
                  Text('Where to?', style: AppTextStyles.body14Bold),
                ],
              ),
            ),
          ),

          SizedBox(height: 2.h),
          InkWell(
            child: const Image(
              image: AssetImage('assets/images/promotion/promo.png'),
            ),
          ),
        ],
      ),
    );
  }
}
