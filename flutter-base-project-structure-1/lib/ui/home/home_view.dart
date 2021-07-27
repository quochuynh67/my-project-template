import 'package:flutter/material.dart';
import 'package:flutterbaseproject/base/base_state_bloc.dart';

import 'home_bloc.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends BaseStateBloc<HomeView, HomeBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Home Screen"),
        ),
      ),
    );
  }
}
