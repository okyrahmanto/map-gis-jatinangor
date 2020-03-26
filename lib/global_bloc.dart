import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalBloc {
  // BehaviorSubject<Day> _selectedDay$;
  // BehaviorSubject<Day> get selectedDay$ => _selectedDay$.stream;

  // BehaviorSubject<Period> _selectedPeriod$;
  // BehaviorSubject<Period> get selectedPeriod$ => _selectedPeriod$.stream;
  bool isPopupAlreadyShown = false;

  //BehaviorSubject<List<Medicine>> _medicineList$;
  //BehaviorSubject<List<Medicine>> get medicineList$ => _medicineList$;

  GlobalBloc() {
    //_medicineList$ = BehaviorSubject<List<Medicine>>.seeded([]);
   // makeMedicineList();
    // _selectedDay$ = BehaviorSubject<Day>.seeded(Day.Saturday);
    // _selectedPeriod$ = BehaviorSubject<Period>.seeded(Period.Week);
  }

  // void updateSelectedDay(Day day) {
  //   _selectedDay$.add(day);
  // }

  // void updateSelectedPeriod(Period period) {
  //   _selectedPeriod$.add(period);
  // }

  

  void dispose() {
    // _selectedDay$.close();
    // _selectedPeriod$.close();
    //_medicineList$.close();
  }

  void setPopUpAlreadyShown() => isPopupAlreadyShown = true;
    
  

  bool get getPopUpAlreadyShown => isPopupAlreadyShown;

}
