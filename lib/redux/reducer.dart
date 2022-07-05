import 'package:flutter_demo/redux/actions_user.dart';
import 'package:flutter_demo/redux/studen.dart';
import 'package:flutter_demo/redux/app_state.dart';

AppState userReducer(AppState previousState, dynamic action) {
  if (action is RestoreToken) {
    return AppState(
      action.isLoading,
      action.isSignout,
      Student(
          action.student.token,
          action.student.docNumId,
          action.student.persPaterno,
          action.student.persMaterno,
          action.student.persNombre),
    );
  } else if (action is SignIn) {
    return AppState(
      action.isLoading,
      action.isSignout,
      Student(
          action.student.token,
          action.student.docNumId,
          action.student.persPaterno,
          action.student.persMaterno,
          action.student.persNombre),
    );
  } else if (action is SignOut) {
    return AppState(
      action.isLoading,
      action.isSignout,
      Student(
          action.student.token,
          action.student.docNumId,
          action.student.persPaterno,
          action.student.persMaterno,
          action.student.persNombre),
    );
  }
  return previousState;
}
