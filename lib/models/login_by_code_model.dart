class LoginByCodeModel{
  LoginByCodeModel();
String? token;
LoginByCodeDataModel? userData;
GetCarByNumberModel? carData;
LoginByCodeModel.fromJson(Map<String,dynamic>?json)

{
  token=json?['token'];
  userData=LoginByCodeDataModel.fromJson(json?['data']['user']);
  carData=GetCarByNumberModel.fromJson(json?['data']['car']);
}


}

class LoginByCodeDataModel{
  LoginByCodeDataModel();

  String? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  bool? active;
  String? car;
  String? carCode;
  String? carNumber;
  String? createdAt;
  String? updatedAt;
  LoginByCodeDataModel.fromJson(Map<String,dynamic>?json)
  {
    id=json?['_id'];
    name=json?['name'];
    email=json?['email'];
    role=json?['role'];
    active=json?['active'];
    car=json?['Car'];
    carCode=json?['carCode'];
    carNumber=json?['carNumber'];
    createdAt=json?['createdAt'];
    updatedAt=json?['updatedAt'];
    phone=json?['phoneNumber'];

  }

}
class GetCarByNumberModel{
  GetCarByNumberModel();

  String? id;
  String? ownerName;
  String? carNumber;
  int? phoneNumber;
  String? email;
  String? carIdNumber;
  String? color;
  String? state;
  String? brand;
  String? category;
  String? model;
  String? generatedCode;
  String? generatedPassword;
  int? periodicRepairs;
  int? nonPeriodicRepairs;
  bool? repairing;
  int? distance;
  String?motorNumber;
  String?chassisNumber;
  List<dynamic>?componentState;
  String?nextRepairDate;
  String?lastRepairDate;


  GetCarByNumberModel.fromJson(Map<String,dynamic>?json)
  {
    state=json?['State'];
    id=json?['_id'];
    ownerName=json?['ownerName'];
    carNumber=json?['carNumber'];
    phoneNumber=json?['phoneNumber'];
    email=json?['email'];
    carIdNumber=json?['carIdNumber'];
    color=json?['color'];
    brand=json?['brand'];
    category=json?['category'];
    model=json?['model'];
    generatedCode=json?['generatedCode'];
    generatedPassword=json?['generatedPassword'];
    periodicRepairs=json?['periodicRepairs'];
    nonPeriodicRepairs=json?['nonPeriodicRepairs'];
    repairing=json?['repairing'];
    componentState=json?['componentState'];
    motorNumber=json?['motorNumber'];
    nextRepairDate=json?['nextRepairDate'];
    lastRepairDate=json?['lastRepairDate'];
    distance=json?['distances'];
    chassisNumber=json?['chassisNumber'];



  }

}
