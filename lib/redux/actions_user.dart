import 'package:flutter_demo/redux/studen.dart';

class RestoreToken {
  bool isLoading;
  bool isSignout;
  Student student;

  RestoreToken(this.isLoading, this.isSignout, this.student);
}

class SignIn {
  bool isLoading;
  bool isSignout;
  Student student;

  SignIn(this.isLoading, this.isSignout, this.student);
}

class SignOut {
  bool isLoading;
  bool isSignout;
  Student student;

  SignOut(this.isLoading, this.isSignout, this.student);
}
