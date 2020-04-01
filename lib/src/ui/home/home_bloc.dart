import 'dart:convert';

import 'package:gis_jatinangor/src/models/errors.dart';
import 'package:gis_jatinangor/src/models/user_profile.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc {

  BehaviorSubject<UserProfile> _userStates$;
  BehaviorSubject<UserProfile> get user$ => _userStates$.stream;
  
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

  HomeBloc() {
   // _selectedMedicineType$ =
   //     BehaviorSubject<MedicineType>.seeded(MedicineType.None);
    // _checkedDays$ = BehaviorSubject<List<Day>>.seeded([]);
   // _selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
   // _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();
   
  }

  void dispose() {
    _userStates$.close();
  }

  void submitError(EntryError error) {
    _errorState$.add(error);
  }

}
