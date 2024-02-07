class CustomerModel {
  String? fullname;
  String? phone;
  String? id;
  String? birthday;

  CustomerModel.fromJson(dynamic json) {
    fullname = json['fullname'] as String;
    phone = json['phone'] as String;
    id = json['id'] as String;
    birthday = json['birthday'] as String;
  }

  CustomerModel({this.birthday, this.fullname, this.id, this.phone});
}
