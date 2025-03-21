class OrderModel {
  String? useremail;
  String? userid;
  String? invoiceid;
  String? orderid;
  String? riderid;
  String? Ownername;
  String? userphone;
  String? status;
  String? time;
  String? Shopname;
  String? Selectfloor;
  String? vehicle_name;
  String? vehicle_color;
  String? vehicle_number;
  String? Ridername;
  String? conatctrider;

  OrderModel({
    this.useremail,
    this.Ownername,
    this.userid,
    this.riderid,
    this.invoiceid,
    this.userphone,
    this.status,
    this.Shopname,
    this.Selectfloor,
    this.vehicle_name,
    this.vehicle_color,
    this.vehicle_number,
    this.Ridername,
    this.conatctrider,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      useremail: data['useremail'],
      userid: data['userId'],
      riderid: data["riderid"],
      invoiceid: data['invoiceid'],
      Shopname: data['Shopname'],
      Ownername: data['Ownername'],
      userphone: data['phone_number'],
      status: data['status'],
      Selectfloor: data['selecfloor'],
      vehicle_name: data['vehicle_name'],
      vehicle_color: data['vehicle_color'],
      vehicle_number: data['vehicle_number'],
      Ridername: data['Ridername'],
      conatctrider: data['Conatctrider'],
    );
  }
}
