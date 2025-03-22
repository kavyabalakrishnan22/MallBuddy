class OrderModel {
  String? useremail;
  // String? Dateandtime;
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
  String? rideremail;
  String? payment;

  OrderModel(
      {this.useremail,
      this.Ownername,
      this.userid,
      // this.Dateandtime,
      this.riderid,
      this.invoiceid,
      this.userphone,
        this.time,
      this.status,
      this.Shopname,
      this.Selectfloor,
      this.vehicle_name,
      this.vehicle_color,
      this.vehicle_number,
      this.Ridername,
      this.conatctrider,
        this.payment,
        this.rideremail,
      this.orderid});

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      useremail: data['useremail'],
      orderid: data['orderid'],
      userid: data['uid'],
      riderid: data["riderid"],
      invoiceid: data['invoiceid'],
      Shopname: data['shopname'],
      Ownername: data['ownername'],
      userphone: data['userphone'],
      status: data['status'],
      Selectfloor: data['selectfloor'],
      vehicle_name: data['vehicle_name'],
      vehicle_color: data['vehicle_color'],
      vehicle_number: data['vehicle_number'],
      Ridername: data['ridername'],
      conatctrider: data['contact_rider'],
      rideremail: data['rideremail'],
      payment: data['payment'],
      // Dateandtime: data['Timestamp'],
      time: data['time'],

    );
  }
}
