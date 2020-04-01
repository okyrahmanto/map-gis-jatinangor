import 'dart:convert';
import 'package:gis_jatinangor/src/models/errors.dart';
import 'package:gis_jatinangor/src/models/user_profile.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterBloc {


  // BehaviorSubject<List<Day>> _checkedDays$;
  // BehaviorSubject<List<Day>> get checkedDays$ => _checkedDays$;

  //BehaviorSubject<int> _selectedInterval$;
  //BehaviorSubject<int> get selectedInterval$ => _selectedInterval$;

  //BehaviorSubject<String> _selectedTimeOfDay$;
  //BehaviorSubject<String> get selectedTimeOfDay$ => _selectedTimeOfDay$;

  BehaviorSubject<EntryError> _errorState$;
  BehaviorSubject<EntryError> get errorState$ => _errorState$;

  RegisterBloc() {
   // _selectedMedicineType$ =
   //     BehaviorSubject<MedicineType>.seeded(MedicineType.None);
    // _checkedDays$ = BehaviorSubject<List<Day>>.seeded([]);
   // _selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
   // _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();
  }

  void dispose() {

  }

  void submitError(EntryError error) {
    _errorState$.add(error);
  }


  Future<bool> saveUserProfile(UserProfile user) async {
      SharedPreferences sharedUser = await SharedPreferences.getInstance();
      //List<String> jsonList = sharedUser.getStringList('userProfile');
      //Map<String, dynamic> tempMap = user.toJson();
      //jsonList.add(jsonEncode(tempMap));
      sharedUser.setString('userProfile', jsonEncode(user.toJson()));
      sharedUser.setBool('isLoggedIn', true);
      return true;
  }

  Future<bool> saveUserProfileDbServer(UserProfile user) async {
      String url = 'https://api.easy-parking.ourcode.site';
      var response = await http.post(
        url, 
        body: 
          {'nama': user.getNama,
           'email': user.getEmail,
           'noTelepon': user.getNoTelepon,
           'idFirebase': user.getIdFirebase,
           'password': user.getPassword,
           'jenisKelamin': user.getJenisKelamin,
           'asalKota': user.getAsalKota
           }
        );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return true;
  }

}
