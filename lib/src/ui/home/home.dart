import 'package:flutter/material.dart';
import 'package:gis_jatinangor/src/ui/home/home_bloc.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc _homeBloc;
  @override
  void initState() {
    _homeBloc = HomeBloc();
  }


  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    return Container(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Container(
              child: Center(
                child: Text("hello EasyParking"),
              )
        )
      )
    );
  }
}

