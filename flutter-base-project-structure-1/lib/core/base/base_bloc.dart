import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

enum ScreenState { NORMAL, LOADING, WHITE_LOADING }

abstract class BaseBloc {
  final BehaviorSubject<ScreenState> _bsScreenState = BehaviorSubject();

  // use to show error message dialog
  final PublishSubject<String> _psErrorMessage = PublishSubject();

  // use to show success message dialog
  final PublishSubject<String> _psSuccessMessage = PublishSubject();

  void closeScreenState() => _bsScreenState.close();

  BehaviorSubject<ScreenState> getScreenState() => _bsScreenState;

  PublishSubject<String> getErrorMessage() => _psErrorMessage;

  PublishSubject<String> getSuccessMessage() => _psSuccessMessage;

  void addScreenState(ScreenState screenState) {
    if (_bsScreenState != null && !_bsScreenState.isClosed) {
      _bsScreenState.add(screenState);
    }
  }

  void addErrorMessage(String error) {
    if (_psErrorMessage != null && !_psErrorMessage.isClosed) {
      _psErrorMessage.add(error);
    }
  }

  void addSuccessMessage(String message) {
    if (_psSuccessMessage != null && !_psSuccessMessage.isClosed) {
      _psSuccessMessage.add(message);
    }
  }

  @mustCallSuper
  void dispose() {
    _bsScreenState.close();
    _psErrorMessage.close();
    _psSuccessMessage.close();
  }
}
