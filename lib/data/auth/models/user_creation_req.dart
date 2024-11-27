class UserCreationReq {
  String ? email;
  String ? password;
  String ? firstName;
  String ? lastName;
  int ? gender;
  String ? age;

  UserCreationReq({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}