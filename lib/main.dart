import 'package:flutter/material.dart';
import 'package:gis_jatinangor/global_bloc.dart';
import 'package:gis_jatinangor/src/ui/landing/landing.dart';
//import 'package:pemuda_bismillah/src/ui/homepage/homepage.dart';
import 'package:provider/provider.dart';

import 'src/ui/maps/maps.dart';

void main() {
  runApp(GisJatinangor());
}

class GisJatinangor extends StatefulWidget {
  @override
  _GisJatinangorState createState() => _GisJatinangorState();
}

class _GisJatinangorState extends State<GisJatinangor> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          brightness: Brightness.light,
        ),
        home: Landing(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
