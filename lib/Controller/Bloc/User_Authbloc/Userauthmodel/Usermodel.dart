class UserModel {
  String? email;
  String? password;
  String? uid;
  String? name;
  String? phone;
  String? status;
  String? Shopname;
  String? Subtitle;
  String? Ban;
  String? Image;




  UserModel(
      {this.email,
      this.password,
      this.name,
      this.uid,
      this.phone,
      this.status,
      this.Ban,
      this.Image,
        this.Shopname,
        this.Subtitle,

      });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'],
      uid: data['userId'],
      name: data['name'],
      phone: data['phone_number'],
      status: data['status'],
      Ban: data['ban'],
      Image: data['imagepath'],
      Shopname: data['Shopname'],
      Subtitle: data['subtitle'],

    );
  }
}
