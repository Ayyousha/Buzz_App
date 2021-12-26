class UsersModels {

  String? uId ;
  String? name ;
  String? email ;
  String? password ;
  String? Phone ;


  UsersModels({
    this.uId,
    this.name,
    this.email,
    this.password,
    this.Phone,

});

  UsersModels.fromModels(Map<String,dynamic> Json)
  {
    uId = Json['uId'];
    name = Json['name'];
    email = Json['email'];
    password = Json['password'];
    Phone = Json['Phone'];
  }

  Map<String,dynamic> toJson()
  {
    return {
      'uId':uId,
      'name':name,
      'email':email,
      'password':password,
      'Phone':Phone,
    };
  }
}