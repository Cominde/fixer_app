class GetHomePramsModel{
  GetHomePramsModel();
  DateTime? createdDate ;
  DateTime? expectedDate ;
  double? completedServicesRatio;
  String? state;
  DateTime? lastRepairDate;
  DateTime?nextRepairDate;
  int? periodicRepairs;
  int ?nonPeriodicRepairs;
  GetHomePramsModel.fromJson(Map <String,dynamic>?json)
  {
    json=json?['data'];
    periodicRepairs=json?['periodicRepairs'];
    nonPeriodicRepairs=json?['nonperiodicRepairs'];
    if (json?['createdDate']!=null) {
      createdDate=DateTime.parse(json?['createdDate']);
    }
    if (json?['expectedDate']!=null) {
      expectedDate=DateTime.parse(json?['expectedDate']);
    }

    completedServicesRatio=json?['completedServicesRatio']*1.0;
    state=json?['state'];
    if(json?['lastRepairDate']!=null) {
      lastRepairDate=DateTime.parse(json?['lastRepairDate']);
    }
    if (json?['nextRepairDate']!=null) {
      nextRepairDate=DateTime.parse(json?['nextRepairDate']);
    }
  }
}