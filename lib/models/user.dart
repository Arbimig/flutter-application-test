class User {
  final String uid;
  final String phone;

  User({required this.uid, required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phone': phone,
    };
  }
}