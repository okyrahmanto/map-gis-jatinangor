import 'dart:convert';

import 'package:gis_jatinangor/src/models/errors.dart';
import 'package:gis_jatinangor/src/models/user_profile.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawerBloc {

  BehaviorSubject<UserProfile> _userStates$;
  BehaviorSubject<UserProfile> get user$ => _userStates$;
  
  UserProfile _user;
  UserProfile get getUser => _user;

  // BehaviorSubject<List<Day>> _checkedDays$;
  // BehaviorSubject<List<Day>> get checkedDays$ => _checkedDays$;

  //BehaviorSubject<int> _selectedInterval$;
  //BehaviorSubject<int> get selectedInterval$ => _selectedInterval$;

  //BehaviorSubject<String> _selectedTimeOfDay$;
  //BehaviorSubject<String> get selectedTimeOfDay$ => _selectedTimeOfDay$;

  BehaviorSubject<EntryError> _errorState$;
  BehaviorSubject<EntryError> get errorState$ => _errorState$;

  HomeDrawerBloc() {
   // _selectedMedicineType$ =
   //     BehaviorSubject<MedicineType>.seeded(MedicineType.None);
    // _checkedDays$ = BehaviorSubject<List<Day>>.seeded([]);
   // _selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
   // _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _userStates$ = BehaviorSubject<UserProfile>.seeded(null);
    getUserProfile().then((value) {
      _user = value;
    });
  }

  void dispose() {
    _userStates$.close();
    
    // _checkedDays$.close();
    //_selectedTimeOfDay$.close();
    //_selectedInterval$.close();
  }

  void submitError(EntryError error) {
    _errorState$.add(error);
  }

  

  
  

  Future<bool> saveUserProfile(UserProfile user) async {
      SharedPreferences sharedUser = await SharedPreferences.getInstance();
      //List<String> jsonList = sharedUser.getStringList('userProfile');
      //Map<String, dynamic> tempMap = user.toJson();
      //jsonList.add(jsonEncode(tempMap));
      sharedUser.setString('userProfile', user.toString());
      sharedUser.setBool('isLoggedIn', true);
      return true;
  }

  Future<UserProfile> getUserProfile() async {
      SharedPreferences sharedUser = await SharedPreferences.getInstance();
      UserProfile userProfile = UserProfile.fromJson(jsonDecode(sharedUser.getString('userProfile')));
      _userStates$.add(userProfile);
      //print(sharedUser.getString('userProfile'));
      //List<String> jsonList = sharedUser.getStringList('userProfile');
      //Map<String, dynamic> tempMap = user.toJson();
      //jsonList.add(jsonEncode(tempMap));
      //sharedUser.setString('userProfile', user.toString());
      //sharedUser.setBool('isLoggedIn', true);
      return userProfile;
  }

  Future<bool> signOut() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    sharedUser.setBool('isLoggedIn', false);
    return true;
  }
}
