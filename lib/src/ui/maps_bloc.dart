import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gis_jatinangor/src/common/errors.dart';
import 'package:gis_jatinangor/src/style/map_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';




class MapsBloc {
  //BehaviorSubject<MedicineType> _selectedMedicineType$;
  //BehaviorSubject<MedicineType> get selectedMedicineType =>
  //    _selectedMedicineType$.stream;

  // BehaviorSubject<List<Day>> _checkedDays$;
  // BehaviorSubject<List<Day>> get checkedDays$ => _checkedDays$;

  //BehaviorSubject<int> _selectedInterval$;
  //BehaviorSubject<int> get selectedInterval$ => _selectedInterval$;

  //BehaviorSubject<String> _selectedTimeOfDay$;
  //BehaviorSubject<String> get selectedTimeOfDay$ => _selectedTimeOfDay$;

  //BehaviorSubject<EntryError> _errorState$;
  //BehaviorSubject<EntryError> get errorState$ => _errorState$;

  static const double CAMERA_ZOOM = 13;
  static const double CAMERA_TILT = 0;
  static const double CAMERA_BEARING = 30;
  static const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
  static const LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);

  Completer<GoogleMapController> _controller;
    // this set will hold my markers
    Set<Marker> _markers;
    // this will hold the generated polylines
    Set<Polyline> _polylines;
    // this will hold each polyline coordinate as Lat and Lng pairs
    List<LatLng> polylineCoordinates;
    // this is the key object - the PolylinePoints
    // which generates every polyline between start and finish

    Set<Polygon> _polygones;

    List<LatLng> polygonCoordinates;

    PolylinePoints polylinePoints;
    String googleAPIKey;
    // for my custom icons
    BitmapDescriptor sourceIcon;
    BitmapDescriptor destinationIcon;

    BehaviorSubject<Set<Marker>> _markers$;
    BehaviorSubject<Set<Marker>> get getMarkers$ => _markers$;

    BehaviorSubject<Set<Polyline>> _polylines$;
    BehaviorSubject<Set<Polyline>> get getPolylines$ => _polylines$;

    BehaviorSubject<Set<Polygon>> _polygones$;
    BehaviorSubject<Set<Polygon>> get getPolygones$ => _polygones$;
  

  MapsBloc() {
    _polygones$ = BehaviorSubject<Set<Polygon>>.seeded({});
    _polylines$ = BehaviorSubject<Set<Polyline>>.seeded({});
    _markers$ = BehaviorSubject<Set<Marker>>.seeded({});
    _controller = Completer();
    _markers = {};
    _polylines = {};
    polylineCoordinates = [];
    _polygones = {};
    polygonCoordinates = [];
    polylinePoints = PolylinePoints();
    googleAPIKey = "AIzaSyDtecH6UKFgDTnTICjSTw_nBzI5nsmt8oE";
    //_selectedMedicineType$ =
    //    BehaviorSubject<MedicineType>.seeded(MedicineType.None);
    // _checkedDays$ = BehaviorSubject<List<Day>>.seeded([]);
    //_selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
    //_selectedInterval$ = BehaviorSubject<int>.seeded(0);
    //_errorState$ = BehaviorSubject<EntryError>();
    setSourceAndDestinationIcons();
  }

  void dispose() {
    
    //_selectedMedicineType$.close();
    // _checkedDays$.close();
    //_selectedTimeOfDay$.close();
    //_selectedInterval$.close();
  }

  void setSourceAndDestinationIcons() async {
      sourceIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/ic_driving_pin.png');
      destinationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'assets/icon/ic_finish_marker.png');
  }

  setPolylines() async {

        List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
            googleAPIKey,
            SOURCE_LOCATION.latitude,
            SOURCE_LOCATION.longitude,
            DEST_LOCATION.latitude,
            DEST_LOCATION.longitude);
        if (result.isNotEmpty) {
          // loop through all PointLatLng points and convert them
          // to a list of LatLng, required by the Polyline
          result.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            polygonCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        }

        // create a Polyline instance
          // with an id, an RGB color and the list of LatLng pairs
          Polyline polyline = Polyline(
              polylineId: PolylineId("poly"),
              color: Color.fromARGB(255, 40, 122, 198),
              points: polylineCoordinates);

          // add the constructed polyline as a set of points
          // to the polyline set, which will eventually
          // end up showing up on the map
          _polylines.add(polyline);

          Polygon polygon = Polygon(
            polygonId: PolygonId("polygon1"),
            fillColor: Color.fromARGB(255, 78, 19, 198),
            strokeColor: Color.fromARGB(255, 40, 122, 198),
            points: polygonCoordinates
          );
          _polygones.add(polygon);

  }

  void onMapCreated(GoogleMapController controller) {
      controller.setMapStyle(MapUtils.mapStyles);
      _controller.complete(controller);
      setMapPins();
      setPolylines();
  }

  void setMapPins() {
      
        
      
  }
  
  void submitError(EntryError error) {
    //_errorState$.add(error);
  }

  void updateInterval(int interval) {
    //_selectedInterval$.add(interval);
  }

  void updateTime(String time) {
    //_selectedTimeOfDay$.add(time);
  }

  // void addtoDays(Day day) {
  //   List<Day> _updatedDayList = _checkedDays$.value;
  //   if (_updatedDayList.contains(day)) {
  //     _updatedDayList.remove(day);
  //   } else {
  //     _updatedDayList.add(day);
  //   }
  //   _checkedDays$.add(_updatedDayList);
  // }

  void updateSelectedMedicine() {
    //MedicineType _tempType = _selectedMedicineType$.value;
    //if (type == _tempType) {
    //  _selectedMedicineType$.add(MedicineType.None);
    //} else {
    //  _selectedMedicineType$.add(type);
    //}
  }
}