import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:katon_taxi25/common/controller/services/profileDataCRUDServices.dart';
import 'package:katon_taxi25/common/model/profileDataModel.dart';
import 'package:katon_taxi25/constant/constants.dart';

class ProfileDataProvider extends ChangeNotifier {
  ProfileDataModel? profileData;

  getProfileData() async {
    profileData =
        await ProfileDataCRUDServices.getProfileDataFromRealTimeDatabase(
          auth.currentUser!.phoneNumber!,
        );
    log(profileData!.toMap().toString());
    notifyListeners();
  }
}
