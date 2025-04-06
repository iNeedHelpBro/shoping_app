import 'package:flutter/material.dart';

final navi = GlobalKey<NavigatorState>();

class NavigatorService {
  static NavigatorService navigate = NavigatorService();

  NavigatorService();

  Future<dynamic> popthenPush(String route) {
    return navi.currentState!.popAndPushNamed('/$route');
  }

  void stayInCurrentPage() {
    if (navi.currentState!.canPop()) {
      navi.currentState!.pop();
    }
  }
}
