import 'package:flutter_demo/redux/studen.dart';

class AppState {
  bool isLoading;
  bool isSignout;
  Student student;

  AppState(this.isLoading, this.isSignout, this.student);

  AppState.initialState()
      : isLoading = false,
        isSignout = false,
        student = Student("", "", "", "", "");
}
