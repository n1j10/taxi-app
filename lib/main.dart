import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:katon_taxi25/common/controller/provider/authProvider.dart';
import 'package:katon_taxi25/common/controller/provider/locattionProvider.dart';
import 'package:katon_taxi25/common/controller/provider/profileDataProvider.dart';
import 'package:katon_taxi25/common/view/authScreens/loginScreen.dart';
import 'package:katon_taxi25/common/view/authScreens/otpScreen.dart';
import 'package:katon_taxi25/common/view/registrationScreen/registrationScreen.dart';
import 'package:katon_taxi25/common/view/signInLogic/signInLogin.dart';
import 'package:katon_taxi25/constant/utils/colors.dart';
import 'package:katon_taxi25/driver/controller/provider/rideRequestProvider.dart';
import 'package:katon_taxi25/driver/controller/services/mapsProviderDriver.dart';
import 'package:katon_taxi25/driver/view/accountScreenDriver/accountScreenRider.dart';
import 'package:katon_taxi25/driver/view/activityScreenDriver/activityScreen.dart';
import 'package:katon_taxi25/driver/view/homeScreenDriver/driverHomeScreen.dart';
import 'package:katon_taxi25/firebase_options.dart';
import 'package:katon_taxi25/rider/view/account/accountScreenRider.dart';
import 'package:katon_taxi25/rider/view/bookARideScreen/bookARideScreen.dart';
import 'package:katon_taxi25/rider/view/homeScreen/riderHomeScreen.dart';
import 'package:katon_taxi25/rider/view/selectPickupAndDropLocationScreen/selectPickupAndDropLocationScreen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Uber());
}

class Uber extends StatefulWidget {
  const Uber({super.key});

  @override
  State<Uber> createState() => _UberState();
}

class _UberState extends State<Uber> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, _, __) {
        return MultiProvider(
          providers: [
            // ! Common Providers
            ChangeNotifierProvider<MobileAuthProvider>(
              create: (_) => MobileAuthProvider(),
            ),
            ChangeNotifierProvider<LocationProvider>(
              create: (_) => LocationProvider(),
            ),
            ChangeNotifierProvider<ProfileDataProvider>(
              create: (_) => ProfileDataProvider(),
            ),
            // ! Rider Providers
            // ChangeNotifierProvider<BottomNavBarRiderProvider>(
            //   create: (_) => BottomNavBarRiderProvider(),
            // ),
            // ChangeNotifierProvider<RideRequestProvider>(
            //   create: (_) => RideRequestProvider(),
            // ),
            // ! Driver Providers
            // ChangeNotifierProvider<BottomNavBarDriverProvider>(
            //   create: (_) => BottomNavBarDriverProvider(),
            // ),
            ChangeNotifierProvider<MapsProviderDriver>(
              create: (_) => MapsProviderDriver(),
            ),
            ChangeNotifierProvider<RideRequestProviderDriver>(
              create: (_) => RideRequestProviderDriver(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(color: white, elevation: 0),
            ),
            home: HomeScreenDriver(),
          ),
        );
        // return
      },
    );
  }
}
