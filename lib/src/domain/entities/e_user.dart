class EntitiesUser {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String? organization;

  EntitiesUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    this.organization,
  });

  EntitiesUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
    String? organization,
  }) {
    return EntitiesUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      organization: organization ?? this.organization,
    );
  }

  factory EntitiesUser.fromJSON(Map<String, dynamic> map) {
    return EntitiesUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      organization: map['organization'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'organization': organization,
    };
  }
}
