// مودل المستخدم (الموظف)
class UserModel {
  int? id;
  String? name;
  String? email;
  String? role;

  UserModel({this.id, this.name, this.email, this.role});

  // تحويل البيانات من JSON إلى Model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  // تحويل المودل إلى Map (مفيد في حال أردت تحديث بيانات البروفايل لاحقاً)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}
