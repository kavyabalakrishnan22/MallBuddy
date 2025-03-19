class BuddyModel {
  String? email;
  String? password;
  String? uid;
  String? name;
  String? phone;
  String? status;
  String? Ban;
  String? Image;
  String? Dob;
  String? Gender;

  BuddyModel(
      {this.email,
      this.password,
      this.name,
      this.uid,
      this.phone,
      this.status,
      this.Ban,
      this.Image,
      this.Dob,
      this.Gender});

  factory BuddyModel.fromMap(Map<String, dynamic> data) {
    return BuddyModel(
      email: data['email'],
      password: data['password'],
      uid: data['userId'],
      name: data['Customername'],
      phone: data['phone_number'],
      status: data['status'],
      Ban: data['ban'],
      Image: data['image'],
      Dob: data['Dateodbirth'],
      Gender: data['Gender'],
    );
  }
}
