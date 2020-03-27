import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gis_jatinangor/src/common/errors.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';
import 'package:map_controller/map_controller.dart';




class MapsBloc {
  BehaviorSubject<Position> _position$;
  BehaviorSubject<Position> get getPosition => _position$.stream;

  StreamSubscription<Position> _positionStream;

  MapController _mapController;
  StatefulMapController _statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> _sub;

  MapController get getMapController => _mapController; 
  StatefulMapController get getStatefulMapController => _statefulMapController;
  


  
  
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

    // this set will hold my markers
    Set<Marker> _markers;
    // this will hold the generated polylines
    Set<Polyline> _polylines;
    // this will hold each polyline coordinate as Lat and Lng pairs

    Set<Polygon> _polygones;


    PolylinePoints polylinePoints;
    String googleAPIKey;
    // for my custom icons


  MapsBloc() {

    _position$ = BehaviorSubject<Position>.seeded(Position(latitude: 0,longitude: 0));
    _markers = {};
    _polylines = {};
    _polygones = {};
    polylinePoints = PolylinePoints();
    googleAPIKey = "AIzaSyDtecH6UKFgDTnTICjSTw_nBzI5nsmt8oE";

    _mapController = MapController();
    _statefulMapController = StatefulMapController(mapController: _mapController);
    
    //_selectedMedicineType$ =
    //    BehaviorSubject<MedicineType>.seeded(MedicineType.None);
    // _checkedDays$ = BehaviorSubject<List<Day>>.seeded([]);
    //_selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
    //_selectedInterval$ = BehaviorSubject<int>.seeded(0);
    //_errorState$ = BehaviorSubject<EntryError>();
    _statefulMapController.onReady.then((_) => print("The map controller is ready"));
    _sub = _statefulMapController.changeFeed.listen((onData) {
     print(onData);
    });
    //_sub = _statefulMapController.changeFeed.listen((change) => setState(() {}));
    startListenToGetPosition();
  }

  void dispose() {
    _position$.close();
    stopListenToGetPosition();
    _sub.cancel();
    //_selectedMedicineType$.close();
    // _checkedDays$.close();
    //_selectedTimeOfDay$.close();
    //_selectedInterval$.close();
  }

  Future<void> startListenToGetPosition() async {
    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    _position$.add(position);
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    _positionStream = geolocator.getPositionStream(locationOptions).listen(
        (Position position) {
          _position$.add(position);
          _statefulMapController.addMarker(marker: deviceLocation(position),name: "deviceLocation");
            print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
        });
    
  }

  Marker deviceLocation(Position position) {
    return Marker(
      point: LatLng(position.latitude, position.longitude),
      height: 10,
      width: 10,
      builder: (ctx) => Container(
                        child: Icon(
                          Icons.brightness_1,
                          color: Colors.blue,
                        ),
                      )
    );
  }

  stopListenToGetPosition() {
    _positionStream.cancel();
  }

  void zoomOut() {
    _statefulMapController.zoomOut();
  }

  void zoomIn() {
    _statefulMapController.zoomIn();
  }

  void centerOnLiveMarker() async {
    print("hei");
    Position pos =  await getPosition.last;
    LatLng centerPosition = LatLng(30, 114);
    _statefulMapController.centerOnPoint(centerPosition);
    _mapController.move(centerPosition, 8);
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

  void updateSelectedMedicine() {
    //MedicineType _tempType = _selectedMedicineType$.value;
    //if (type == _tempType) {
    //  _selectedMedicineType$.add(MedicineType.None);
    //} else {
    //  _selectedMedicineType$.add(type);
    //}
  }
}