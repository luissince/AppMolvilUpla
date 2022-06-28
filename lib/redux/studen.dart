class Student {
  String token = "";
  String docNumId = "";
  String persPaterno = "";
  String persMaterno = "";
  String persNombre = "";

  String get getToken {
    return token;
  }

  Student(this.token, this.docNumId, this.persPaterno, this.persMaterno,
      this.persNombre);
}
