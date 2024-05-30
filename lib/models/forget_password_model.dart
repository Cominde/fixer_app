class ForgetPasswordModel{
  ForgetPasswordModel();
  String? status;
  String ? message;
  ForgetPasswordModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }
}