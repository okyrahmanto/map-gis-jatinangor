import 'dart:convert';
import 'package:gis_jatinangor/src/models/errors.dart';
import 'package:gis_jatinangor/src/models/user_profile.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginBloc {

  // BehaviorSubject<List<Day>> _checkedDays$;
  // BehaviorSubject<List<Day>> get checkedDays$ => _checkedDays$;

  //BehaviorSubject<int> _selectedInterval$;
  //BehaviorSubject<int> get selectedInterval$ => _selectedInterval$;

  //BehaviorSubject<String> _selectedTimeOfDay$;
  //BehaviorSubject<String> get selectedTimeOfDay$ => _selectedTimeOfDay$;

  BehaviorSubject<EntryError> _errorState$;
  BehaviorSubject<EntryError> get errorState$ => _errorState$;

  LoginBloc() {
   // _selectedMedicineType$ =
   //     BehaviorSubject<MedicineType>.seeded(MedicineType.None);
    // _checkedDays$ = BehaviorSubject<List<Day>>.seeded([]);
   // _selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
   // _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();
  }

  void dispose() {
    //_selectedMedicineType$.close();
    // _checkedDays$.close();
    //_selectedTimeOfDay$.close();
    //_selectedInterval$.close();
  }

  void submitError(EntryError error) {
    _errorState$.add(error);
  }

  bool signInWithEmail(String email, String password) {
    
    return true;
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


  Future<UserProfile> getUserProfileServerDb(String uid, String password) async {
     String url = 'https://api.easy-parking.ourcode.site';
      var response = await http.post(
        url, 
        body: 
          {
           'idFirebase': uid
           }
        );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Map<String, dynamic> userData = jsonDecode(response.body);
      
      return UserProfile(password: password, email: userData['email'], 
        idFirebase: uid, jenisKelamin: userData['jenisKelamin'], 
        nama: userData['nama'], noTelepon: userData['noTelepon'], asalKota: userData['asalKota']);
  }

  // login
}
