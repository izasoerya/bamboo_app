class EntitiesUser {
  final String uid;
  final String name;
  final String email;
  final String password;

  EntitiesUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
  });

  EntitiesUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
  }) {
    return EntitiesUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory EntitiesUser.fromJSON(Map<String, dynamic> map) {
    return EntitiesUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
