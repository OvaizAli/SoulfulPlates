import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/enums/view_state.dart';

class BaseController extends GetxController {
  ViewStateEnum _state = ViewStateEnum.idle;

  ViewStateEnum get state => _state;

  BuildContext? baseContext;

  RxInt uploadProgress = 0.obs;

  /// Change The Value Of View State for progress bars
  void setLoaderState(ViewStateEnum viewState) {
    // onWidgetDidBuild(callback: () {
    try {
      if (state != viewState) _state = viewState;
      update();
    } catch (e) {
      debugPrint('This is error while building');
    }
    // });
  }

  ViewStateEnum _buttonState = ViewStateEnum.idle;

  ViewStateEnum get buttonState => _buttonState;

  /// Change The Value Of View State for progress bars
  void setButtonLoaderState(ViewStateEnum viewState) {
    try {
      if (buttonState != viewState) _buttonState = viewState;
      update();
    } catch (e) {
      debugPrint('This is error while building');
    }
  }
}
