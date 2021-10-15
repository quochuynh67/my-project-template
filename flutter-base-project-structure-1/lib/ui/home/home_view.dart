import 'package:flutter/material.dart';
import 'package:flutterbaseproject/core/base/base_state_bloc.dart';
import 'package:flutterbaseproject/generated/l10n.dart';

import 'home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State createState() => _HomeViewState();
}

class _HomeViewState extends BaseStateBloc<HomeView, HomeBloc> {
  bool _isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isEnglish = !_isEnglish;
            if (_isEnglish) {
              S.delegate.load(const Locale('en', 'EN'));
              setTheme(ThemeData.light());
            } else {
              S.delegate.load(const Locale('vi', 'VI'));
              setTheme(ThemeData.dark());
            }
          });
        },
      ),
      body: Center(
        child: Text(S.current.home_title),
      ),
    );
  }
}
