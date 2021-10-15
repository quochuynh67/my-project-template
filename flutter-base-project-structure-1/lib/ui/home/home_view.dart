import 'package:flutter/material.dart';
import 'package:flutterbaseproject/base/base_state_bloc.dart';

import 'home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State createState() => _HomeViewState();
}

class _HomeViewState extends BaseStateBloc<HomeView, HomeBloc> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
