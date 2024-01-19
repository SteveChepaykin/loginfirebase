class UserModel {
  final String id;
  late final String firstname;
  late final String secondname;
  late final String lastname;

  UserModel.fromMap(this.id, Map<String, dynamic> map) {
    firstname = map['firstname'] != null ? map['firstname'] as String : throw 'NEED EMAIL IN USER $id';
    secondname = map['secondname'] != null ? map['secondname'] as String : throw 'NEED NICKNAME IN USER $id';
    lastname = map['lastname'] != null ? map['lastname'] as String : throw 'NEED IDENTIFIER IN USER $id';
  }
}